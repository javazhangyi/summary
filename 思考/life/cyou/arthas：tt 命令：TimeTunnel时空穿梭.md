#### arthas tt 命令

1. **说明：**arthas源于Greys，是在上面的二次开发，功能较Greys更为完善，类似的还有BTrace

   

2. **需求：**在开发和测试单机环境，日志不完善，复现问题，需要多次激发bug

   

3. **arthas实现**：通过agent 收集记录方法入参，然后再内部调用激发

   

4. **优点：**代码无侵入

   

5. **缺点：**1)直接将数据保存再jvm 上，数据过度导致jvm 撑爆；2)需要提前做出记录动作

   

[arthas tt命令说明](https://arthas.gitee.io/tt.html)

[Greys wiki](https://github.com/oldmanpushcart/greys-anatomy/wiki)