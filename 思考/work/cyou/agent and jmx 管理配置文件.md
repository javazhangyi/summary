**agent and jmx 管理配置文件**

依赖：通过agent 配合jmx 来管理配置文件，例如@value ，因为是属性，无法织入代码

必须找到方法切入点切入来进行管理，意味着agent and jmx 必须依赖于spring容器



**代码切入点**：org.springframework.beans.factory.annotation.InjectionMetadata.inject()



**agent jmx 执行的思路**

1. 找到合适的植入点（已实现）

2. 将相关属性代理管理（已实现）

3. 将管理类升级为Mbean（已实现）

4. 调用jxm 修改Mbean 相关方法（已实现）

5. 集群管理（未实现）

6. .....待补充

   

**现存的问题：**

1. 不支持xml <value>配置形式，
2. 暂时支持String 类型
3. 集群管理如何实现
4. 是否需要修改保存，下次自动加载
5. .....待补充