
按照概率统计，我一辈子，遇见的一半的人是异性
可能也会遇见无数个同名的你
但是一辈子中，你就是你，世界独一无二
是我想用一辈子时间去珍惜，关心，疼爱的人
今天可能会失败的概率有99
今天我也愿意去尝试
看你哭，看你笑，


ssh webadmin@58.220.29.171 "/home/builder/evn/cloud_builder_server.sh stop"
ssh webadmin@58.220.29.171 "sleep 2; rm -rf /home/builder/evn/newBuilder.jar"
scp ${WORKSPACE}/target/newBuilder*.jar webadmin@58.220.29.171:"/home/builder/evn/newBuilder.jar"
ssh webadmin@58.220.29.171 "/home/builder/evn/cloud_builder_server.sh start"