# Received fatal alert: internal_error

​	问题描述：大量请求失败，失败描述信息“Received fatal alert: internal_error”；第一次看见这样的问题，先查看是否是agent log （日志框架导致）因为是自己的写的，但是有bug，后面排除了，在去查看原始日志，没有查到任何有用信息，因为日志信息全被格式化了，后来有幸百度这篇[博客](https://blog.csdn.net/cuiqiang60/article/details/82694261)，和我的问题一摸一样，通过他的

买描述分析，然后通过自己的测试，这个问题，是偶现，在通过最后一句关键描

述，服务端没有及时回复客户端，想了想，我们这这边为客户端，所以问题应该是

对方导致的，再通过，大量请求分析，可能是对方的端点服务不足

