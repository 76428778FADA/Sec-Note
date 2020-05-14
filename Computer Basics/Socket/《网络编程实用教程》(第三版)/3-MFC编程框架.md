### 1. MFC概述

MFC应用程序框架，简称MFC框架，是由MFC（Microsoft Foundation Class Library）中的各种类结合起来构成的。

Microsoft Visual C++提供了相应的工具来完成这个工作：

用应用程序向导（AppWizard）可以生成应用程序的骨架文件（代码和资源等）；

用资源编辑器可以直观地设计用户接口；用类向导（ClassWizard）可以将代码添加到骨架文件；

用编译器可以通过类库实现应用程序特定的逻辑。MFC实现了对应用程序概念的封装，把类、类的继承、动态约束、类的关系和相互作用等封装起来。 

**MFC类的继承关系**

MFC将众多类的共同特性抽象出来，设计出一些基类，作为实现其他类的基础。有两个类十分重要。

CObject是MFC的根类，绝大多数MFC类是从它派生的。CObject 实现了一些重要的特性，包括动态类信息、动态创建、对象序列化、对程序调试的支持等等。所有从CObject派生的类都将具备或者可以具备CObject所拥有的特性。 

另一个是CCmdTarget类，它是从CObject派生的。CCmdTarget类通过进一步封装一些属性和方法，提供了消息处理的架构。在MFC中，任何可以处理消息的类都是从CCmdTarget类派生的。

针对每种不同的对象，MFC都设计了一组类对这些对象进行封装，每一组类都有一个基类，从基类派生出众多更具体的类。这些对象包括以下种类：窗口对象，基类是`CWnd`；应用程序对象，基类是`CwinThread`；文档对象，基类是`Cdocument`，等等。

总之，MFC封装了Win32 API，OLE API，ODBC API等底层函数的功能，并提供更高一层的接口，简化了Windows编程。同时，MFC支持对底层API的直接调用。

**MFC中最重要的封装是对Win32 API的封装，因此，理解Windows 对象和MFC对象之间的关系是理解MFC的一个关键**。所谓Windows对象是Win32下用句柄表示的Windows操作系统对象;所谓MFC对象是C++对象，是一个C++类的实例;

![](https://raw.githubusercontent.com/Qymua/bookmaker-data/master/Qymua/1572075887552.png)

