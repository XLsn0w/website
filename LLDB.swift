//
//  LLDB.swift
//  x
//
//  Created by i on 2020/9/29.
//

import Foundation


/*
 
 LLDB阐述
 LLDB 是一个有着 REPL 的特性和 C++ ,Python 插件的开源调试器。LLDB 绑定在 Xcode 内部，存在于主窗口底部的控制台中。
 调试器允许你在程序运行的特定时暂停它，你可以查看变量的值，执行自定的指令，并且按照你所认为合适的步骤来操作程序的进展。
 

 它的基本语法为

 <command> [<subcommand> [<subcommand>...]] <action> [-options [option-value]] [argument [argument...]]
 在XCode中，我们需要在程序暂停进入调试状态时才能使用LLDB，可以通过breakpoint、watchpoint、或者XCode的调试台自带的暂停按钮使程序暂停。

 快捷键
 为了方便查询，就直接在文章开头po出常用的快捷键菜单把~

 快捷键功能          命令
 暂停/继续          cmd + ctrl + Y
 控制台显示/隐藏     cmd + Y
 光标切换到控制台     cmd + shift + C
 清空控制台          cmd + K
 step over         F6
 step into    F7
 step out    F8
 HELP
 LLDB的入门与Linux命令入门类似，可以通过执行help命令来查询这个命令的意义和详细参数


 从描述中我们能看出thread backtrace是用来查询暂停时的线程堆栈的，并了解了可以带入的入参。

 唯一匹配原则
 LLDB有个很省事的特性，如果输入的字母已经能匹配到某个命令，就可以直接执行，等于输入了完整的命令。


 变量查询与修改
 expression

 expression 可简写为e，作用为执行一个表达式，首当其冲，它肯定可以用来查询当前堆栈变量的值。

 当然e的更主要的用法是通过执行表达式，动态修改当前线程堆栈变量的值，
 从而达到调试的目的（其实查询也很主要，只是会用另一种方式查询）。
 
 比如，我们可以在某个if..else..的语句前打上断点，直接修改条件表达式的值，
 使程序覆盖了不同分支，而不用苦心积虑地停止程序、hard code变量值来进行调试，节省了一大坨修改与编译时间。


 我们也可以通过执行表达式，实时改变当前的UI界面，方便界面代码的调试，
 
 e @import UIKit
 e cellItem.layer.borderWidth = 1
 这里有个特殊的问题，由于程序已经被断点暂停了，因此执行UI更新的线程也被暂停了。
 我们可以通过让程序继续运行，也可以通过另一条表达式来更新UI。
 
 e (void)[CATransaction flush]

 > 我们也可以用 `call` 来代替 `expression --`，其实我觉得用`e`更方便。 =。=
 p、po

 在上面说过，在调试中，我们一般用e命令来修改变量，而查询变量一般用p与po命令。
 po的作用为打印对象，事实上，我们可以通过help po得知，po是expression -O --的简写，我们可以通过它打印出对象，而不是打印对象的指针。而值得一提的是，在 help expression 返回的帮助信息中，我们可以知道，po命令会尝试调用对象的 description 方法来取得对象信息，因此我们也可以重载某个对象的description方法，使我们调试的时候能获得可读性更强，更全面的信息。

 -(NSString*)description
 {
     return [NSString stringWithFormat:@"Portal[%@, %@, %@, %@, %@, %@, %@]", ssid, mpUrl, ticket, authUrl, _openid, _tid, extend];
 }
 p即是print，也是expression --的缩写，与po不同，它不会打出对象的详细信息，只会打印出一个$符号，数字，再加上一段地址信息。由于po命令下，对象的description 有可能被随便乱改，没有输出地址消息。

 $符号在LLDB中代表着变量的分配。每次使用p后，会自动为你分配一个变量，后面再次想使用这个变量时，就可以直接使用。我们可以直接使用这个地址做一些转换，获取对象的信息


 断点
 breakpoint
 所有调试都是由断点开始的，我们接触的最多，就是以breakpoint命令为基础的断点。
 一般我们对breakpoint命令使用得不多，而是在XCode的GUI界面中直接添加断点。除了直接触发程序暂停供调试外，我们可以进行进一步的配置。

 添加condition，一般用于多次调用的函数或者循坏的代码中，在作用域内达到某个条件，才会触发程序暂停
 忽略次数，这个很容易理解，在忽略触发几次后再触发暂停
 添加Action，为这个断点添加子命令、脚本、shell命令、声效（有个毛线用）等Action，我的理解是一个脚本化的功能，我们可以在断点的基础上添加一些方便调试的脚本，提高调试效率。
 自动继续，配合上面的添加Action，我们就可以不用一次又一次的暂停程序进行调试来查询某些值（大型程序中断一次还是会有卡顿），直接用Action将需要的信息打印在控制台，一次性查看即可。
 除去在代码中直接点击添加断点外，我们也可以在 command + 7 breakpoint页面下直接添加相关的断点。我们常用的有 Exception Breakpoint 与 Symbolic Breakpoint

 Add Exception Breakpoint
 Exception Breakpoint为异常断点。在某些情况下，TableView的数据源与UI操作不一致，或者容器插入了nil的指针，将消息传至野指针，都会导致程序的crash，并且LLDB输出的信息不是很友好。加上异常断点，能够使程序在抛出异常的栈自动暂停，可直接定位导致抛出异常的代码。在一般的开发流程中，都建议开启这个异常断点，反正你总是会crash的嘿嘿。
 Add Symbolic Breakpoint
 Symbolic Breakpoint 为符号断点。有时候，我们并不清楚程序会在什么情况下调用某一个函数，那我们可以通过符号断点来获取调用该函数时的程序堆栈。当然，在自己实现的类，我们也可以在该函数实现的地方打上断点，但如果需要定位其他框架提供的API的调用，就只能使用符号断点啦。
 当然，LLDB的breakpoint命令也可以实现上述的功能，因为不常用，所以这里就简单列举一些用法。 breakpoint set -n trigger //在所有类的trigger函数实现中打上断点

     breakpoint set -f ViewController.m -n trigger //在ViewController.m中的trigger方法打上断点
     breakpoint set -f ViewController.m -l 50 //在ViewController.m的50行打上断点
     breakpoint set -f ViewController.m -n trigger: -c testCondition > 5 //在ViewController.m中的trigger方法打上断点并添加condition， testCondition大于5时触发断点
     breakpoint set -n trigger -o //单次断点
     breakpoint command add -o "frame info" 3 //在设置的三号断点加入子命令frame info
     breakpoint list // 列出所有断点
     breakpoint delete 3 //删除3号断点
 watchpoint
 有时候我们会关心类的某个属性什么时候被人修改了，最简单的方法当然就是在setter的方法打断点，或者在@property的属性生命行打上断点。这样当对象的setter方法被调用时，就会触发这个断点。

 当然这么做是有缺点的，对于直接访问内存地址的修改，setter方法的断点并没有办法监控得到，因此我们需要用到watchpoint命令。
 watchpoint命令在XCode的GUI中也可以直接使用，当程序暂停时，我们能对当前程序栈中的变量设置watchpoint。值得注意的是，watchpoint是直接设置到该变量所在的内存地址上的，所以当这个变量释放了后，watchpoint仍然是对这个地址的内存生效的。

 我们也可以在LLDB中直接用watchpoint命令，可以通过选项实现更多效果。
     watchpoint set self->testVar     //为该变量地址设置watchpoint
     watchpoint set expression 0x00007fb27b4969e0 //为该内存地址设置watchpoint，内存地址可从前文提及的`p`命令获取
     watchpoint command add -o 'frame info' 1  //为watchpoint 1号加上子命令 `frame info`
     watchpoint list //列出所有watchpoint
     watchpoint delete // 删除所有watchpoint
 堆栈
 thread 和 bt
 bt即是thread backtrace，作用是打印出当前线程的堆栈信息。当程序发生了crash后，我们可以用该命令打印出发生crash的当前的程序堆栈，查询出发生crash的调用路径。由于比较常用，所以LLDB直接给它一个特殊的bt别名。
 thread另一个比较常用的用法是 thread return，调试的时候，我们希望在当前执行的程序堆栈直接返回一个自己想要的值，可以执行该命令直接返回。
 thread return <expr>
 在这个断点中，我们可以执行 thread return NO让该函数调用直接返回NO ，在调试中轻松覆盖任何函数的返回路径。

 frame
 frame即是帧，其实就是当前的程序堆栈，我们输入bt命令，打印出来的其实是当前线程的frame。
 在调试中，一般我们比较关心当前堆栈的变量值，我们可以使用frame variable来获取全部变量值。当然也可以输入特定变量名，来获取单独的变量值，如frame v self-> testVar来获取testVar的值。

 End

 作者：王小明if
 链接：https://www.jianshu.com/p/d6a0a5e39b0e
 来源：简书
 著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
 
 */
