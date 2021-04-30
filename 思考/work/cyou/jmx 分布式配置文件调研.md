### jmx 分布式配置文件调研

**@Value：**

​	spring 容器扫描bean文件，发现该bean 有@value 注解，通过已解析到配置文件，直接注入到该bean的属性；程序运行的时候该bean（没有特殊申明，一般为单例），直接调用该对象属性。

**[apollo](https://github.com/ctripcorp/apollo)：**

​	apollo 是携程管理分布式配置文件项目，spring 容器扫描bean，若发现该bean 存在@Value注解，通过使用一个beanList 保存该bean，当后台推送新的配置文件，通过适配bean上的@Value 注解，适配成功后再通过bean 的反射，改变bean的属性。

**jmx：**

​	jmx 是java已经实现资源管理机制，通过将相关bean升级为Mbean，直接通过接口对该bean属性管理。

**jmx管理配置文件难点：**

​	将.properties等配置文件，通过一个Contans.java 管理，只需要对 Constants.java升级到MBean（代码侵入可忽略），如果需要更改配置文件，通过后台直接操作MBean。

```java
@ManagedResource
public class Constants {
    @Value("${catalina.base}")
    private String catalina_base;
    
    @ManagedAttribute
    public String getCatalina_base() {...}
    @ManagedAttribute
    public void setCatalina_base(String catalina_base) {...}
}
```

​	现存情况，@Value注解和log(....),类似，较为均匀分布的系统的各个层面，引用@value注解类比较广泛；对于配置文件的相关属性也是分布在**各个bean属性**

**解决方案：**

1. 将所有的@value统一通过Constants管理，然后直接升级Constants 为Mbean

   - 优点：简单明了，操作一次就生效；所有的容器都支持jmx

   - 缺点：项目改动较大，对所有项目都需要变动

2. 将现有的已经注解的bena，升级为Mbean（操作繁琐不建议）

3. 直接在现有项目，使用apollo：

   - 优点：代码侵入可忽略，
   - 缺点：且需要研读源码，维护apollo后台
   - 客户端环境：spring3.1+，jdk1.7+

**apollo可用性考虑：**

​	项目加载配置文件顺序：jvm参数>apollo后台配置参数>apollo本地缓存的配置>项目配置文件

|     场景     |       影响       |                降级                |
| :----------: | :--------------: | :--------------------------------: |
| Portal不可用 | 无法读取最新配置 | 客户端重启时，读取本地缓存配置文件 |

当后台推送新的配置文件，会在该机器下的相关目录生成缓存文件，[详细信息参考](https://github.com/ctripcorp/apollo/wiki/Apollo%E9%85%8D%E7%BD%AE%E4%B8%AD%E5%BF%83%E8%AE%BE%E8%AE%A1)

**现存平台项目spring版本**

|   项目名    | spring版本  | apollo是否支持 |
| :---------: | :---------: | :------------: |
|   gateway   |    3.2.4    |       Y        |
| sdk-billing |    3.2.4    |       Y        |
| sdk-service |    3.2.4    |       Y        |
|    其他     | spring-boot |       Y        |