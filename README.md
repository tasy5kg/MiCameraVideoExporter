# 小米摄像机视频导出工具

本工具可将小米摄像机录制的视频以小时为单位导出。

## 使用步骤

本工具需要在 Windows 64 位系统上运行。

1. 将小米摄像机的储存卡取出，将其通过读卡器连接电脑；

2. [下载本工具](https://github.com/tasy5kg/MiCameraVideoExporter/releases/download/2/2.zip)并解压到任意目录；

3. 选择与你的摄像机机型匹配的```小米摄像机视频导出工具-*.cmd```（```*```为机型名称），运行，然后按照提示，输入储存卡所在的盘符，以及要导出的视频的日期和时间；

4. 只需大约一分钟，即可完成导出。

## 支持的摄像机机型

此工具已适配：

- 小米智能摄像机标准版
- 小米智能摄像机云台版2K（[感谢@pinglun](https://github.com/tasy5kg/MiCameraVideoExporter/issues/1)）

其它机型未测试是否可用。如果你使用的是其它型号的小米摄像机，欢迎试用现有的版本，并通过 [Issue](https://github.com/tasy5kg/MiCameraVideoExporter/issues) 反馈是否可用。感谢你的反馈。

## 第三方库

本工具调用了第三方库 [ffmpeg](https://ffmpeg.org/)。