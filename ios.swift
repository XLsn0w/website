//
//  ios.swift
//  NewBegin
//
//  Created by i on 2020/9/27.
//  Copyright © 2020 xlsn0w. All rights reserved.
//

import UIKit

class ios: NSObject {

}

/*

 1.#import和#include的区别，@class代表什么？
 
 #import会代入头文件的所有信息，包括实例变量和方法等，
 #include也是带入文件的所有信息，跟#import差异是在#import引用的文件只会被引用一次，不会递归包含的问题
 @class代表的意思是，不需要导入文件内容，也不需要知道如何定义的，我只告诉编译器这个就是个类的名称，

 2.谈谈Objective-C的内存管理方式和过程？
 在App运行时创造了大量的对象，Objective-C中的对象时存储在堆中的，系统并不会自动释放堆中的内存(基本类型也就是值类型是由系统自己管理的，放在栈上)
 OC的内存管理是需要开发去手动维护的，之前xcode4.2版本之前是MRC，之后则是ARC(主要由runtime和LLVM协作完成)。

 一、引用计数
 在Xcode4.2以后的版本中都是引入了ARC机制，程序编译时xcode可以自动给你的代码添加内存释放代码，
 但是如果编写释放内存的代码就会报错，所以需要在xcode中主动关闭ARC，这样才能有助于ObjC的理解。
 
 在ObjC中，每个对象内部都会有一个retainCount整数，叫"引用计数"，当一个对象创建之后它的引用计数为1，
 当调用这个对象的alloc、retain、new、copy方法之后引用计数会在动在原有的基础上加1，
 当调用这个对象的release方法之后它的引用计数会减1，如果一个对象的引用计数为0，
 则系统会自动调用这个对象的dealloc方法来销毁这个对象，在手动管理内存的时候需要遵循一个原则谁创建、谁释放。
 
 当用户调用方法的时候实际上是在向这个对象发送一条消息，且ObjC中允许向一个nil的对象发送消息，
 在释放完成以后最好直接给这个对象设置为nil，为了防止野指针的出现，当这个对象的引用计数为0的时候，
 系统会自动调用dealloc方法来销毁对象，可以在这里将所有的野指针设置为nil。
 
 二、属性参数
 @property自动实现你的属性的getter、setter方法，并且提供一些参数供选择
 
 参数          详解
 atomic       对属性加锁，多线程下线程安全，默认值
 nonatomic    对属性不加锁，多线程不安全，但是速度快
 readwrite    生成getter、setter方法，可读可写，默认值
 readonly     只生成getter方法，只读
 assign       直接赋值，默认值
 weak         相当于assign，多了一点就是对象被干掉时，weak引用自动设置为nil
 retain       先release原来的值，再retain新值
 strong       跟retain一样，在ARC中，不需要手动释放内存
 copy         先release原来的值，在copy新值
 
 assign， setter方法

 -(void)setNamenum:(int)num{
     _Namenum=num;
 }
 retain，setter方法

 -(void)setNamenum:(calss*)num{
     if(_Namenum != num)
     [_Namenum release];
     _Namenum = [num retain];
 }
 copy，setter方法

 - (void)setNamenum:(calss*)num{
     if(_Namenum != num)
     [_Namenum release];
     _Namenum = [num copy];
 }
 
 自动释放池
 在ObjC中还有一种自动释放机制, 使用的时候首先用@autoreleasepool关键字声明一个代码块，在代码块中初始化你的对象，
 如果对象在初始化的时候加入了autorelease方法，那么在这个代码块执行完成以后，
 在块中只要调用过autorelease方法的对象都会自动调用release方法。这就是自动释放池，
 这样release方法是一起被调用的，可能有点用处。

     @autoreleasepool {
         UserModel *user1 = [[[UserModel alloc]init]autorelease];
         user1.UserName = @"用户1";
         
         UserModel *user2 = [[[UserModel alloc]init]autorelease];
         user2.UserName = @"用户2";
         
     }
 打印结果
 
 2019-01-25 23:26:53.031860+0800 MRC_demo[3264:662385] UserModel = (用户2)dealloc method.
 2019-01-25 23:26:53.031967+0800 MRC_demo[3264:662385] UserModel = (用户1)dealloc method.
 从结果来看自动释放池是一个队列，先进后出，压栈的形式
 
 根据理解又实验了2次：
 
 在autorelease之后user2加上retain，实验证明user2没有被释放，说明autorelease只是调用了一次release
 在autorelease之后user2加上release，程序崩溃Thread 1: EXC_BAD_ACCESS
 (code=EXC_I386_GPFLT)野指针,将user2 = nil就会解决，ObjC可以向nil对象发送消息。
 
 自动释放池的总结
 autorelease不会改变retaincount的值，只是放入自动释放池
 自动释放池，就是在代码块完成以后，调用autorelease的对象自动调用release方法(只是一次)，如果对象的retaincount>1那么就没法释放
 自动释放池是统一销毁，那么在这个代码块中占用的内存会相对来说多一点，可以使用多个自动释放池
 3. Objective-C有私有方法吗？私有变量呢？
 
 在ObjC中按照正常的规则来将是有私有方法，跟私有变量的，只要不在.h文件声明就可以，只是在表面上是这样的，
 因为ObjC是一个动态语言，我们可以通过runtime来动态的获取这些property、方法、ivar，得到名称或者直接修改值都是可以的。
 代码如下：

 /********************************************************/
                        对象类代码
 /********************************************************/
 #import <Foundation/Foundation.h>

 NS_ASSUME_NONNULL_BEGIN

 @interface UserModel : NSObject
 - (instancetype)initWithUserName:(NSString *)name;
 @end

 NS_ASSUME_NONNULL_END


 @interface UserModel ()
 {
     NSString * userName;
 }
 @end

 @implementation UserModel

 - (instancetype)initWithUserName:(NSString *)name{
     
     self = [super init];
     if(self){
         userName = name;
     }
     return self;
 }

 - (void)doing{
     NSLog(@"这是我的私有方法");
 }
 @end

 /********************************************************/
                        调用私有方法代码
         当然这段代码是将所有的对象都得到然后都调用一遍
 /********************************************************/

      int Count;
      Method *methodList = class_copyMethodList([UserModel class], &Count);
      for (unsigned int i = 0; i < Count; i++) {
          Method method = methodList[i];
          NSLog(@"method --> %@", NSStringFromSelector(method_getName(method)));
         objc_msgSend(user, NSSelectorFromString(method_getName(method)));
      }
      
 /********************************************************/
                        调用私有变量代码
             这里是将所有的变量都取出来然后都修改成"我去"
 /********************************************************/

     int varcount;
     Ivar *varlist = class_copyIvarList([user class], &varcount);
     
     for (unsigned int i = 0; i < varcount; i++) {
         Ivar ivar = varlist[i];
         object_setIvarWithStrongDefault(user, ivar, @"我去");
         NSLog(@"%@",object_getIvar(user, ivar));
     }

 当然runtime还是可以做到很多事情并不仅仅是这些，不过从题目来看已经够充分的说明了ObjC是否存在私有变量跟私有方法了。
 答案是严格意义上的私有方法、私有变量是不存在。

 4.Objective-C的类可以多重继承么？可以实现多个接口么？Category是什么？重写一个类的方式用继承好还是分类好？为什么？
 Objc的类不可以多重继承，延伸问题有没有可能去实现多继承？

 有的，两种方式：
 1）伪继承消息转发，这样可以本类中没有这个方式有第二次机会可以去调用别的类中的方法
 2）委托，也就是protocol的方式实现，当我需要某个方法的时候，我直接调用协议的方法，发送给实现方法的对象(也就是遵守协议的对象，这个对象我完全不必知道具体内容)，这样就，通过委托的形式，也就没有必要去考虑多继承的问题，专心搞自己的类就可以。
 Category是什么？重写一个类的方式用继承好还是用分类好？为什么？

 Catogory是分类， 重写类的话，应该首先看一下具体的需求：
 1）如果只是为了扩展一些方法，不修改类的实现、内容等，那么使用分类比较好，因为分类扩展方法仅限这个分类当中有效，并不会影响原有类的具体实现。
 2）如果有目的性的需要修改类中的某一项内容、方法，那么最好的形式还是继承比较好。
 
 5. Swift中类(class)和结构体(struct)有什么区别？
 class是引用类型，struct是值类型。
 值类型在传递和赋值时将进行复制，而引用类型只会使用引用对象的一个"指向"。所以两者之间的区别就是两个类型的区别。

 class中有struct没有的内容：

 可以继承、这样子类可以使用父类的特性和方法。
 类型转换可以在运行时检查和解释一下实例的类型。
 可以使用deinit来释放资源。
 一个类可以被多次引用。
 
 struct的优势：

 结构较小，适用于复制操作，相比一下class的实例被多次引用，struct更加安全。
 无须担心内存泄漏或者多线程冲突问题。
 
 6.Swift是面向对象编程还是函数式的编程语言？
 Swift既是面向对象的编程语言，也是函数式的编程语言。

 面向对象:因为支持类的封装、继承、多态，从这一点看，Swift是一个面向对象的语言

 函数式：为什么说是函数式编程？因为Swift支持map、flatmap更加强调运算结果而不是中间过程。

 7.Objective-C中的函数式编程？
 在OC中典型的函数式编程式masonry这个框架。在OC中的函数式编程实现的原理：

 如果想再去调用别的方法，那么就需要返回一个对象。
 如果想用()去执行，那么需要返回一个block。
 如果想让返回的block再调用对象的方法，那么这个block就需要返回一个对象(即返回值为一个对象的block)。
 
 8.Swift中可选型(optioonal)？
 在Swift中，可选型式为了表达当一个变量值为空的情况，当一个变量值为空时，他就是nil。
 在Swift中，无论变量时引用类型还是值类型，都可以时可选型变量。
 ! ?这两个的区别。？可选类型， ！隐式解析可选类型

 9.OBjective-C当中有没有可选类型？
 OC当中没有明确提出可选型的概念，所有的引用类型都可以为nil，以此来表示变量值为空的情况，
 当时在Swift中就明确提出了可选型的概念，并扩大到了值类型。

 10.Swift中，什么是泛型(Generics)？
 泛型主要是为了增加代码的灵活性，它可以使对应的代码满足任意类型的变量，比如
 func sum<T>(_ a: inout T,_ b: inout T){
 (a,b) = (b,a)
 }
 // inout 关键字的含义是告诉编辑器，将值类型的对象跟引用类型对象一样都是按照引用传递，也就是地址传递。
 这个方法T就是泛型，它既可以是任意对象，也可以是任意的值类型，但是必须a与b的类型保持一致，主要Swift是一个类型安全的语言，两个变量之间进行运算，赋值操作必须要类型一致。

 11.Swift说明比较关键字Open、Public、internal、File-private和private关键字
 上述几个关键字统称是：访问权限控制
 Swift有5个级别的访问控制权限，从高到低依次为Open、Public、Internal、File-private、Private。

 Open是最高权限，修饰的类和方法可以在任意的Module中被访问和重写
 Public的权限仅次于Open。与Open唯一的区别在于，它修饰的对象可以在任意Module中被访问，但不能重写。
 Internal是默认的权限。它表示只能在当前定义的Module中访问和重写，它可以被一个Module中的多个文件访问，但不可以被其他的Module访问。
 File-private修饰的对象只能在当前文件中使用。
 private最低级别的访问权限，它修饰的对象只能在作用域中使用。即使在同一个文件中的其他作用域，也没法访问。
 
 12.Swift中说明并比较关键字：Strong，Weak和Unownet
 Strong代表强引用，是默认属。当一个对象被声明为Strong时，表示父层级对该对象有一个强引用的指向，该对象的引用计数+1

 Weak代表弱引用，如果一个对象在被声明为Weak的时候，那么父层级的对象对该对象并没有指向，该对象的引用计数也不会+1，当该对象被释放掉的时候，这个对象会自动设置成nil，继续访问不会崩溃。

 unownet与弱引用的本质一样。不同的是对象在被释放掉的时候，依然会有一个无效的引用指向该对象，它不是optional也不是nil，访问就会崩溃。

 加入weak和unownet是为了防止strong带来的循环引用，简单的说当两个对象互相有一个强引用指向对方的时候。就会导致两个对象都无法在内存中得到释放从而导致的循环引用。

 访问对象可能被释放的时候请用weak，比如是delegate，访问你对象一定不会被释放的时候请用unownet。

 13.在Swift中，如何理解copy-on-write
 在值类型在复制的时候，复制的对象和原来的对象实际上在内存上面都指向同一个对象，当且仅当修改复制后的对象时，才会在内存中重新创建一个新的对象
 let array = [1,2,3]
 var array1 = array
 array1.append(4)
 然后这两个对象的地址就会不一样了。以上

 14.在Swift中什么是属性观察(property observer)？
 当前类型内对特定的属性进行监听，并作出相应的行为，就是属性观察，简单的来说就是类型中的两个方法。
 比方：
 var name:String{
 willSet{
 //将要修改
 }

 didSet{
     //修改完成
 }
 }

 注意当初始化和在类型内部进行修改的时候是不会调用这两个方法的

 15.在Swift中mutating的作用。
 mutating的作用是可以在protocol、enum、struct中定义的方法修改其中的成员变量

 16.在Swift中protocol怎么定义成员变量？
 在protocol中可以声明成员变量、和静态成员变量，但是不能对其进行初始化的操作。
 并且只能是两种状态 get，Set、Get,
 比如：
 protocol MyProtocol{
 var Str:String{  get  } //只读
 var changeStr:String {
  get
  set
  } //可读写
 }

 17.Swift在结构体中如果修改成员变量？
 protocol MyProtocol {
     var changeStr:String {get set} //可读写
 }

 struct UserModel:MyProtocol {
     var changeStr:String
     
     mutating func MyChangeStr(Name:String){
         self.changeStr = Name
     }
 }

 18.Swift如果实现(||)操作
 或操作的本质是，当表达式左边的值为真的时候，无须计算表达式右边的值。
 实现||的操作有三种方式：

 一、普通的实现方式：

     //实现
     func huo(_ value1: Bool, _ value2: Bool) -> Bool {
       if value1 {
         return true
       }
       if value2 {
         return true
       }
        
       return false
     }
     //调用
     let res = huo(vLeft, getRightRes())
 这种方式虽然可以实现或，但是并不高效，即便是左边的值等于true，右边的函数也会调用的。
 如果右边的函数比较耗费性能或者费时操作，在已经确定左边的值为true的情况下，再去执行右边的函数是真没必要去执行的。

 二、闭包概念的或：
     实现
    func huo(_ left:Bool, _ right:()->Bool)->Bool{
         if left{
             return true
         }
         return right()
     }
     //调用
     let res = huo(true) { () -> Bool in
         return getRightRes()
     }
 第二种方式解决了第一种方式中耗费性能耗时的操作。

 三、@autoclosure 关键字优化。
     //实现
     func huo(_ value1: Bool, _ value2: @autoclosure() -> Bool) -> Bool {
       if value1 {
         return true
       }
       return value2()
     }
     //调用
     let res = huo(true, getRightRes())
     这种方式就是第二中方式的优化，加入@autoclosure后，调用时跟第一种方式时一样的形式，它将右边的计算函数隐性的放入了右边的闭包
 19.输入任意一个整数，输出的是输入整数的+2、+3、+4。。。 请定义一个函数来实现。
 func Add(_ num:Int)->(Int)->Int{
     return { value in
         return num + value
     }
 }
 这体现了Swift的函数式编程的思想
 20.写一个函数，求0～100(包括0和100)中为偶数并且恰好是其他数字平方的数字
 在swift中我们需要写的方法是：

 第一种方法：
 func sqNums(_ from:Int,_ to:Int)->[Int] {
     var array:[Int] = [Int]()
     for num in from...to where num%2 == 0 { //查到偶数
         if(from...to).contains(num*num){
             array.append(num*num)
         }
     }
     return array
 }
 这种方法如果在OC当中还是可以的，因为Swift是函数式编程思想的内容，我们换一种方式来思考，0 ～ 100  中找到N*N那么100是最大的，那么100 = 10*10，那么 0～10也就满足了N*N这个条件，然后在判断偶数，在使用Swift的map、filter方法
 
 print({0...10}.map{$0*$0}.filter{$0%2==0}) 一行代码搞定
 
 21.OC中什么是ARC？
 Objective-C的内存管理机制是什么？
 ARC即Automatic Refrence Counting，它是Objective-C的内存管理机制。
 就是在代码中自动加入了retain/release，原先需要手动添加用于管理内存的引用计数的代码可以由编译器自动完成。

 ARC的使用是为了解决对象retain和release匹配的问题。以前因手动管理而造成内存泄漏或者重复释放的问题将不复存在。

 以前需要手动去释放内存，retain了以后必须release释放内存。alloc new retain都需要release，这种操作为MRC(Manual Reference Counting).

 ARC与Garbage Collection的区别在于， Garbage Collection在运行时管理内存，可以解决retain cycle，而ARC在编译时管理内存。

 22.OC中什么情况下会出现循环引用？
 循环引用就是两个或以上对象互相强引用，当这些对象释放的时候，导致互相释放不掉，这种情况就是循环引用，
 
 这也是内存泄漏的一种情况。 在OC中解决方法就是在一个对象的强引用Strong(强引用) 改成weak(弱引用)。

 循环引用其实在Xcode工具中是可以检测到的。比如：

 Xcode->Debug Memory Graph检查，就是在一个对象中打一个断点，
 点击输出控制器上面的三个点用线串起来的按钮来查看类中的引用图，
 根据该不该释放的问题来查找是否循环引用了。

 在Xcode左上角，感叹号按钮由一个runtime的选项，一般如果有内存泄漏会直接在里面暴漏出来

 Xcode->Product->analyze 来发现内存泄漏问题。

 23.说明比较OC中关键字：strong、weak、assign和Copy
 参数    详解
 strong    表示指向并拥有该对象，其修饰的对象引用计数+1，该对象只要引用计数不为0，就不会被销毁。
 当然，强行将其设为nil也可以销毁它。不需要手动释放内存
 
 weak    类似assign，一般情况下修饰对象，而assign一般修饰值类型，比assign多了一点就是对象被销毁的时候，weak引用会自动设置为nil，防止野指针的发生，修饰的对象引用计数不会改变。在一个强引用引用该对象时，如果这个强引用被释放掉了，那么同样，这个对象也会被释放。
 
 assign    直接赋值，默认值，主要是修饰一些基本数据类型，值类型，比如说NSInteger、CGFloat，这些数值主要存在于栈中。
 
 copy
 
 copy与strong类似，不同之处是，strong赋值的话，会是指针的复制，并且内容是同一块儿地址，
 而copy不同，每次赋值或复制的时候都会复制一份新的对象，指针指向不同的地址，copy一般用在修饰有对应可变类型的不可变对象上，如NSString,NSArray和NSDictionary。
 在OC中基本的数据类型的属性变量的关键字是(atomic、readwrite、assign)；
 普通属性的默认关键字是(atomic、readwrite、strong)

 24.说明比较关键字：atomic和nonatomic
 参数    详情
 atomic    作用是系统生成的setter/getter方法会保证get、set操作的完整性，不受其他线程影响，如果A线程的getter方法运行到一半的时候，线程B调用了setter方法，那么线程A还是能够得到一个完好无损的对象，所以速度比较慢，atomic比nonatomic安全，但是并不是绝对的安全，比方说多个线程同时调用set和get方法，会导致获得的对象不一样，如果想要线程绝对的安全，就要用@synchronized 代码块。
 nonatomic    这个修饰的对象并不会保证setter/getter方法的完整性，但是速度比atomic快，当多线程访问的时候有可能得到的是未初始化的对象，当然也不是线程安全的。
 
 25.atomic是百分之百线程安全的吗？
 atomic不是百分之百线程安全的，只是保证多线程的情况下，getter、setter方法调用的完整性，
 在多线程访问的情况下，能够有效完整的调用完setter、getter方法。
 
 但是在多线程并发的情况下，得到的结果不能够保证是统一的，
 
 比如说线程A在调用属性M的setter方法并且进行到了一半的时候，线程B调用了getter方法想要获取到M的内容，那么线程B拿到的是线程A赋值之前的内容，如果需求是要获取到线程A赋完值以后的内容，那么这就是线程不安全的实例。

 26.Runloop和线程的关系？
 runloop是每一个线程一直运行的一个对象，它主要用来负责响应需要处理的各种事件和消息。
 每一个线程都有且仅有一个runloop与其对应。没有线程，就没有runloop。

 在所有的线程中，只有主线程的runloop是默认启动的。
 main函数会设置一个NSRunLoop对象。而其他线程的runloop默认是没有启动的。
 可以通过[NSRunLoop currentRunLoop]获取当前的runloop，调用run启动。

 27.说明并比较关键字:__weak和__block。
 __weak与weak基本上是一样的，
 前者修饰变量(variable)，
 后者修饰属性(perproty)。

 __weak主要用于防止在block中的循环引用，
 __block也用于修饰变量。它是引用修饰，所以其修饰的值是动态变化的。就是可以被重新赋值。
 __block用于修饰某些block内部将要修改的外部的变量。

 __weak和__block的使用场景几乎与block息息相关。而所谓block，就是Objective-C对于闭包的实现。闭包就是没有名字的函数，或者可以理解为指向函数的指针。

 使用注意，如果在block中去修改外部的变量(除静态、全局)，
 需要在block外部声明__weak重新修饰，然后在block中在用__block在去修饰__weak修饰的变量。
 __weak修饰是为了告诉编译器，重新修饰的变量是一个不使用引用计数的弱引用，
 而在block中使用__block是为了告诉编译器，我需要在block使用这个变量不管是外面的变量是否被释放掉，我的block中的这个变量要在整个block函数中应该全程都是被保留的。如：

 __weak typeof(self)weakself = self;
 self.Copyblock = ^{
     __block typeof(weakself)blockself = weakself;
     [blockself.array addObject:[UserModel new]];
 };
 self.Copyblock();
 
 28.什么是block？它和代理的区别是什么？
 block是一个回调的方式，本质上也是一个OC对象，一个函数方法对象。
 block分为三种：静态block、栈block、堆block。

 block和代理的区别：

 block集中代码块，而delegate则是分散代码块。

 block可读性更好、使用简单，而delegate则需要声明协议、声明代理属性、遵守协议、实现协议的方法。而block只需要声明属性、实现就可以。

 block是一个轻量级的回调，可以直接上下文，因为代码内联运行效率更高，block就是一个对象，实现了匿名函数的功能。
 所以把block当作一个成员变量、属性、参数使用，使用起来非常的灵活。就想AFN的请求数据，GCD的多线程，而delegate就没有这么灵活。

 block适用于轻便、简单的回掉，比如一些简单回调网络数据，相对来说接口比较少的回调等， 如果是一些复杂的函数回掉，并且接口过多，那么使用block就会显得不利于维护、耦合性太大，
 而代理则完全相反，接口回调少的时候使用起来比较麻烦，但是一旦接口回调多的时候，会显得更加清晰明朗。

 block的运行成本高，block出栈的时候需要将数据从栈内存拷贝到堆内存，如是对象是加计数，那么使用完或者block置为nil后才能被消除；delegate只是保存了一个对象指针，直接回调，并没有额外消耗。

 block容易产生循环引用，当然（delegate需要weak修饰，不然也是有循环引用)，因为为了block不被系统回收，所以我们都用copy关键字修饰，实行强引用，block对捕获的变量也都是强引用，所以就会造成循环引用。

 如果使用？ 1）简单的来讲优先使用block 2） 如果回调的状态多，超过2个以上就是用代理 3）如果回调过于频繁，还是使用代理。 按需使用

 29.属性中copy和Strong的面试问题？
 @property(nonatomic,strong)NSString * title;
 @property(nonatomic,assign)int num;
 第一个属性：title：

 NSString这个类型有可变不可变的类型，NSMutableString这个类型，并且是NSString的子类。那么使用strong的话容易被外界所修改。比方说：
 类A中定义了title属性(nonatomic,strong)，类A中有个变量(NSMutableString)的变量Mutabletitle

 //mutableString这个参数是类A的一个变量类型是NSMutableString
 NSMutableString* mutableString = [[NSMutableString alloc]initWithString:@"mutablestring"];
     
 UserModel *user = [[UserModel alloc]init];
     
 //首先将字符串赋值
 user.title = @"title";
 user.title = mutableString; //这时候title==mutableString==@"mutablestring"
     
 //修改mutableString的值
 [mutableString appendString:@"111"];
     
 //得到的结果是user.title == mutableString == @"mutablestring111"
 NSLog(@"title=%@--%p mutableString=%@--%p",user.title,user.title,mutableString,mutableString);

 如果在开发中，我们只是修改mutableString的值而并不想修改user.title的值，那么这样做就是错误的。
 分析：由于strong修饰的属性是强引用，user.title = mutableString 这个意思就是直接指针复制，这两个变量所拥有的内存地址是一样的，当一个变量修改另外的变量也会跟着修改。

 第二个属性num，这个属性不应该用int来修饰，int是代表32位的整型数据，而在iOS中有个整型NSinteger这个属性，表示在32位系统中是32位的整型，在64位系统中会是64位整型数据， NSinteger更加准确。当然还有 CGFloat代替float NSUInteger代替unsigned。

 改正代码：

 @property(nonatomic, copy) NSString * title;
 @property(nonatomic, assign) NSInteger num;
 
 30.阅读下述代码，看这个代码是否能够更加优化，在架构解耦中应该怎么做。
 typedef enum{
     normal = 0;
     VIP = 1;
 }UserPowerType;

 @interface UserModel:NSObject
 
 @property(nonatomic,copy)NSString *name;
 @property(nonatomic,strong)UIImage *UserIcon;
 @property(nonatomic,assign)UserPowerType Type;
 
 @end

 1.首先enum的定义，apple官方推荐使用NS_ENUM来定义枚举类型，同时在每个枚举的前面需加上枚举的名称，也方便swift和OC混编。
 2.UIImage这个参数不应该出现在UserModel中，因为UIImage这个明显是UIKit中的组建，是放到View 中的内容，无论是MVC还是MVVM或者是VIPER，Model都应该跟View划清界限。

 优化后的代码：

 typedef NS_ENUM(NSUInteger, UserPowerType) {
     UserPowerTypeNormal,
     UserPowerTypeVIP,
 };

 @interface UserModel:NSObject
 @property(nonatomic,copy)NSString *name;
 @property(nonatomic,strong)NSData *UserIconData;
 @property(nonatomic,assign)UserPowerType Type;
 @end
 
 31.阅读下述代码从内存管理中分析其真正的意义。
 NSString *str1 =@"helloworld";
 NSString *str2 =@"helloworld";
 if(str1 == str2){
     NSLog(@"equal");
 }else{
     NSLog(@"not equal");
 }
 NSLog(@"str1=%p,str2=%p",str1,str2);
 ==符号并不是判断这两个值是否相等，而是判断这两个指针是否指向同一个对象，如果要判断两个对象的值是否相同应该用方法isEqualToString这个方法。
 那么上述代码为什么打印出来的结果是equal呐？因为在iOS的编译器环境中，会优化内存分配，
 当两个指针指向两个值一样的NSString时，两者会同时指向一个地址。所以代码打印的结果是equal。
 
 32.阅读下述有关多线程的代码，并说明有什么问题？
 UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(100, 100, 200, 40)];
 label.text = @"123456";
 label.textColor = [UIColor redColor];
 [self.view addSubview:label];
     
 NSOperationQueue *backgroundQueue  = [[NSOperationQueue alloc]init];
 [backgroundQueue addOperationWithBlock:^{
     [NSThread sleepForTimeInterval:4];
     label.text = @"amaze";
 }];
 
 这段代码最大的问题，只要跟刷新界面有关系的内容必须在主线程中调用。

 正确的代码修正：

 UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(100, 100, 200, 40)];
 label.text = @"123456";
 label.textColor = [UIColor redColor];
 [self.view addSubview:label];
     
 NSOperationQueue *backgroundQueue  = [[NSOperationQueue alloc]init];
 [backgroundQueue addOperationWithBlock:^{
     [NSThread sleepForTimeInterval:4];
     [[NSOperationQueue mainQueue] addOperationWithBlock:^{
         label.text = @"amaze";
     }];
 }];
 
 [[NSOperationQueue mainQueue] addOperationWithBlock:^{
     [NSThread sleepForTimeInterval:4];
     label.text = @"amaze";
 }];
 
 33.以ScheduledTimerWithTimeInterval的方式触发的timer，在滑动页面上的列表时，timer会暂停，为什么？该如何解决？
 造成此问题的原因在于滑动页面上的列表时，当前线程的runloop切换了mode的模式，导致timer暂停。

 runloop中的mode主要用来指定事件在runloop中的优先级，具体有以下几种：

 参数    详情
 default(NSDefaultRunLoopMode)     默认设置，一般情况下使用
 Connection(NSConnectionReplyMode)    用于处理NSConnection相关事件，开发者一般用不到
 Modal(NSModalPanelRunLoopMode)    用于处理model panels
 Event Tracking(NSEventTrackingRunLoopMode)    用于处理拖拽和用户交互的模式
 Common (NSRunLoopConmmonModes)    模式合集，默认包括Default、modal和EventTracking三大模式，可以处理几乎所有的事件
 
 根据上面的参数介绍在看这道问题，在滑动列表时，runloop的mode由原来的Default模式切换到EventTracking模式，
 timer原来运作在Default模式中，模式切换了以后自然而然就停止工作了。

 解决方法：方法一是将timer加入NSRunloopCommonModes中。
 方法二是将timer放到另一个线程中，然后开启另一个线程的runloop，
 这样可以保证与主线程互不干扰，而现在主线程正在处理页面滑动。

 代码示例：

 方法一：
 [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];

 方法二：
 dispatch_async(dispatch_get_global_queue(0, 0), ^{
     timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(Repeat) userInfo:nil repeats: YES];
     [[NSRunLoop currentRunLoop] run];
 })

 34.Swift VS Objective-C
 这么多年的Swift完善，Apple的两种语言已经从一开始的分道扬镳，到现在已经有了天壤之别。

 细数两种语言大的方面不一样的地方：

 Swift更注重安全性，比如说Swift的可选、不可选类型，？ ！ 而OC当中并没有这些规定，如果非要说共同点就是iOS9.0之后出现的关键字 _NonNull(不可以为nil） 、_nullable(可以为nil)就算是不遵守这个也就是给个警告，主要是为了混编开发。
 Swfit有面向对象编程、面向协议编程、函数式编程，而OC几乎只有面向对象的编程。
 Swift更加注重值类型的数据结构，而OC遵循了C语言的一套，注重指针和索引。
 Swfit是静态语言，而OC是动态语言。
 
 35.为什么将String、Array和Dictionary设计成值类型？
 
 在Swift中这些设置成值类型，而OC中则是引用类型。具体的分析如下：
 值类型相比较引用类型来说最大的优势是可以高效的使用内存，值类型在栈上进行操作，而引用类型在堆上面进行操作，
 栈的操作知识指针的上下移动，而堆上的操作就需要合并、移位、重新链接。
 
 Swift大幅度减少了堆上的内存分配和回收次数，同时copy-on-write又将值传递和复制的开销降到了最低。
 同时这样设计也是为了线程更加安全，通过Swift的let设置，使得这些数据达到了真正意义上的不变，也从根本上解决了多线程中内访问和操作顺序问题。
 
 36.如何用Swift协议中的部分方法设计成可选(optional)
 方法一： 用OC的方式实现，在方法前面添加 @objc optional

 @objc protocol Myprotocol {
     func requiredFunc()
     @objc optional func optionalFunc()
 }
 方法二：用扩展来实现可选方法，扩展协议

 protocol Myprotocol{

     func requiredFunc()
     func optionalFunc()
 }

 extebsion Myprotocol {

     func optionalFunc() {
         print("to do")
     }

 }

 Class Myclass: Myprotocol {

     func requiredFunc() {
         print("only need to implement the required")
     }

 }

 37.判断下面所述代码有什么问题？
 protocol ProtocolDelegate {
     func doSomething()
 }

 class MyClass {
     weak var delegate:ProtocolDelegate?
 }
 
 weak var delegate:ProtocolDelegate? //报错弱引用只能修饰引用类型，而在Swift中协议是可以被值类型实现，enum、struct等，所以需要区别出来。

 weak关键词用于ARC环境下，为引用类型提供引用计数这样的内存管理，它是不能够修饰值类型的。

 方法一：
 直接在声明的协议前面加上 @objc这样就是告诉编译器这个协议还是OC中的协议，修饰对像一个样就没毛病

 @objc protocol ProtocolDelegate { //方法一
     
     func doSomething()
     
 }
 方法二：
 在声明的协议后面添加关键字 class 告诉编译器只能由class来实现，那么就忽略掉了值类型。

 protocol ProtocolDelegate: class { //方法二
     func doSomething()
 }
 
 38.在Swift和Objective-C的混编中如何在Swift文件中调用OC方法，在OC文件中调用Swift方法
 Swift调用OC

 Swift调用OC需要在ProjectName-Bridging-Header.h中添加OC的头文件，这样就可以调用了，一般Swift项目中添加OC文件就有提示自动添加侨接文件。

 在OC中调用Swift代码，则需要导入Swift生成的头文件ProjectName-Swift.h

 当然还有就是在OC中调用Swift代码需要在Swift方法属性前面添加@objc来声明。

 39.比较Swift和OC中初始化方法(init)的不同
 在OC中初始化方法无法完全保证属性变量完成初始化，也没有对起最警告处理，所以在初始化类的时候，有的属性是空值(nil)，初始化方法和普通方法也并没有实际差别，可以多次调用。

 在Swift中初始化方法必须保证非optional的成员变量得到初始化，同时新增了convenience和required两个修饰初始化方法的关键词，convenience是对初始化方法的补充，但是在内部必须调用同一个类中的designated初始化方法来完成，required是强制子类重写父类的初始化方法。

 40.比较swift跟OC的protocol的异同
 相同点：
 都是作为代理，类似接口

 不同点：
 Swift可以对接口进行抽象，配合扩展、泛型、关联类型等可以实现面向协议编程。同时protocol还可以用于值类型，比如enum、struct等


 
 
 
 41.谈谈对OC和Swift动态特性的理解
 runtime其实就是OC的动态机制。runtime执行的是编译后的代码，这时它可以动态加载对象、添加方法、修改属性、传递信息等。具体过程是，在OC中，对像调用方法时，如[self.tableview reload],经历了两个过程。

 编译阶段： 编译器会将OC代码翻译成objc_msgSend(self.tableview,@slector(reload)),把消息发送给self.tableview。
 运行阶段： 接收者(self.tableview)会响应这个消息，其间可能会直接执行，转发消息，也可能会找不到方法导致程序崩溃。
 所以，整个流程是：编译器翻译->给接收者发送消息->接收者响应消息。

 接收者如何去响应消息，就发生在运行时。runtime执行的是编译后的代码，而代码的具体实现是运行时才能够确定，这时它就可以动态加载对象、添加方法、修改属性、传递消息等。runtime的运行机制就是OC的动态特性。

 Swift公认的是一个静态语言，它的动态特性都是通过桥接OC来实现的，像一些动态的特性其实是可以用Swift的面向协议的编程那样使用的。

 例子：
 在OC中我们去动态的调用一个方法，首先需要判断这个方法是否存在然后再去调用它，这就是纯正的动态特性：代码

 OC的动态特性

 UserModel类的实现
 @implementation UserModel
 - (void)todoSomething{
     NSLog(@"正在做什么事情。");
 }
 @end

 动态调用UserModel的方法。
 UserModel *user = [UserModel new];
 if([user respondsToSelector:NSSelectorFromString(@"todoSomething")]){
     [user performSelector:NSSelectorFromString(@"todoSomething")];
 }
 Swift的面向协议编程

 面向协议的实现代码
 protocol TodoProtocol {
     func todosomething()
 }

 class UserModel: TodoProtocol {
     func todosomething() {
         print("要做的事情")
     }
 }

 调用代码
 let user:UserModel = UserModel()
 if let user1 = user as? TodoProtocol {
     user1.todosomething()
     print("实现了这个协议")
 }else{
     print("没有实现这个协议")
 }
 这样来使用，这个协议的方法，其实这步骤判断不需要因为swift中的协议的方法都是required的没有optional。
 42.谈谈as、as!、as? 含义是什么？
 1)as的三种使用方式

 as第一种用法是将派生类转换成基类，也就是说子类直接转换成父类。 向上转型。
 代码：

 class Animal{
     var name:String
     init(_ name:String){
         self.name = name
     }
 }
 class catanimal : Animal {
 }
 class doganimal: Animal {
 }
 //as 向上强转 子转父
 let cat = catanimal("汤姆") as Animal
 let dog = doganimal("泰克") as Animal

 showAnimalName(cat)
 showAnimalName(dog)
 如果是父类转换成子类，那么这种形式在Swift是会报错的，就算是加上!强转a!运行的时候也会崩溃。

 as第二种用法消除多义性，数据类型转换
 比如说

 let AnimalAge = 3 as Int  //3 有可能是Int 也有可能是CGFloat 也可能是long Int
 let AnimalWeight = 20 as CGFloat
 let AnimalHeight = (50 / 2) as Double
 as的第三种用法switch语句中进行模式匹配，通过switch愈发检测对象的类型，根据对象类型进行处理。
 switch animalType{
     case let animal as catanimal:
         print("是catanimal类型")
     case let animal as doganimal:
         print("是doganimal类型")
     default: break
 }
 2)as!的用法

 向下转型，强制转换类型，有个缺点就是如果转化失败就会报错误。
 一般形式下可以这么使用，

 catanimal是Animal的子类。

 let animal:Animal = catanimal("汤姆")
 let cat = animal as!catanimal
 上述代码就是将类型强制转化，首先要注意一点，在强转之前一定要判断animal这个类是用catanimal这个类初始化的， 如果不这样做的话，是用Animal初始化的，那么在第二行强制转化的话就会报错。

 3)as?的用法

 as?跟as!是一样的用法，只不过as?如果转化不成功的话会直接返回一个nil对象，成功的话返回可选类型。如果说能%100的会成功转化那么请用as!如果说不能的话请用as?

 使用例子：

 let animal:Animal = catanimal("汤姆")
 if let cat = animal as? catanimal {
     print("是catanimal类型")
 }else{
     print("nil")
 }
 43.查看下述代码输出是什么？为什么？
 protocol  Police{
     func HandlingCases()
 }

 extension Police{
     func HandlingCases(){
         print("Police doing Handling cases!" );
     }
 }

 struct Judge:Police{
     func HandlingCases(){
         print("Judge doing Handling cases!" );
     }
 }

 调用代码
 let police1:Police = Judge()
 let police2:Judge = Judge()
     
 police1.HandlingCases()
 police2.HandlingCases()

 两个输出的内容都是Judge doing Handling cases!,
 因为在Swift中protocol声明了某个方法，在没有extension扩展协议的情况下必须在实现类中实现该方法，swift中的协议的方法都是required的，如果extension中实现了该方法，则在实现类Judge中可以不用去实现，一旦实现，那么还是以实现类Judge的实现方法为准。
 HandlingCases方法在Police协议中声明了，police1虽然声明的是Police但是实际实现还是Judge所以根据实际情况是调用了Judge的HandlingCases实现方法。同样道理police2也是如此。

 但是如果说在Police中没有生命方法HandlingCases，其他不变的情况下，那么police1、police2的输出就会不一样了。因为police1的实际类型是Police，Police中并没有声明HandlingCases,但是在类扩展中有实现该方法，实际类调用实际的方法，那么就会调用扩展类中实现HandlingCases，而police2的实际类型是Judge那肯定就会调用Judge中的实现方法。

 所以他们的输出是：

 police1输出 Police doing Handling cases!

 police2输出 Judge doing Handling cases!

 44.message send如果找不到对象，则会如何进行后续处理
 这种形式一般会有两种情况：1）对象是nil； 2）对象不为nil但是就是找不到对应的方法；

 1）对象为空的时候，在OC中向一个nil的对象发送消息是可以的，如果这个方法的返回值是对象那么返回的是nil，如果返回值是结构体，那么就是0.
 2）对象不为空，找不到方法，就会崩溃，报错。

 45.method swizzling 是什么？
 每一个类都会维护一个方法列表，并且方法名跟方法实现是一一对应的，也就是SEL(方法名)和IMP(方法实现的指针)的对应关系，

 method swizzling的意义就是运用runtime的特性跟方法来进行SEL和IMP这一对的IMP进行更换操作。如果SELa对应IMPa SELb对应IMPb 使用method swizzling后可以成为SELa对应IMPb SELb对应IMPa。

 代码实现

 在本类实现2个方法：
 - (void)onefunc{
     
     NSLog(@"one");
     
 }

 - (void)twofunc{
     
     NSLog(@"two");
     
 }

 在本类中调用代码
 SEL one = @selector(onefunc);
     
 Method OneMethod = class_getInstanceMethod([self class], one);
     
 SEL two = @selector(twofunc);
     
 Method TwoMethod = class_getInstanceMethod([self class], two);
     
 method_exchangeImplementations(OneMethod, TwoMethod);

 这样就可以看到调用onefunc会打印two， 调用twofunc会打印one

 46.Swift和OCjective-C的自省(Introspection)有什么不同
 自省在Objective-C中就是：判断一个对象是否属于某个类的操作。它有两种形式。
 [objc isKindOfClass:[SomeClass class]];
 [objc isMemberOfClass:[SomeClass class]];

 第一个判断isKindOfClass是判断objc是否为SomeClass或者其子类的实例对象。
 第二个判断isMemberOfClass是判断objc仅仅是SomeClass这个类(非子类，当前类)的实例对象，并且不能检测任何类都是基于NSObject类。

 这两种判断的前提是objc必须是NSObject的子类。

 Swift中只有isKindOfClass类似的方法is，很多的类并不是继承自NSObject，不过比OC的功能更加强大，is可以判断enum、struct类型

 自省操作一般和动态类型一起出现，比如说OC中的id类型，以及Swift中的可选类型、anyobject。

 cat是animal的子类
 id animal = catInstance;

 if([animal isKindOfClass:[animal class]]){
     NSLog(@"是 animal class");
     if(animal isMemberOfClass:[cat class]){
         NSLog(@"是 cat class");
     }
 }else if([animal isKindOfClass:[any(其他类) class]]){
     NSLog(@"是 其他 class");
 }
 47.能否通过Category给已有的类添加属性(property)
 无论是Swift还是OC都可以用Category来添加属性，只不过添加的方式不一样。

 Objective-C:
 OC中通过Category中直接添加属性(property)会报错，提示找不到getter和setter方法，
 那是因为在Category中不会自动生成这两个方法，解决的方法就是运用runtime，
 关联对象的形式来添加属性，主要涉及到的两个函数是，objc_getAssocicatedObject和objc_setAssociatedObject.
 objc_getAssocicatedObject两个参数： 本类实例对象、 关联属性的key
 objc_setAssociatedObject中的方法有4个参数，分别是 本类实例对象、关联属性的key、新值、关联策略。

 @interface UserModel : NSObject
 @end
 @implementation UserModel
 @end


 @interface UserModel(en)
 @end

 #import "UserModel+En.h"
 #import <objc/runtime.h>

 static void *EnNameKey = &EnNameKey;

 @implementation UserModel(en)

 -(void)setEnName:(NSString *)EnName{
     objc_setAssociatedObject(self, &EnNameKey, EnName, OBJC_ASSOCIATION_COPY_NONATOMIC);
 }

 - (NSString *)EnName{
     return objc_getAssociatedObject(self, &EnNameKey);
 }

 @end

 Swift跟Objective-C的使用方式差不多，如下代码

 class UserModel {
     var Name:String = "小明"
 }
 var EnNameKey:Void?
 extension UserModel{
     
     var EnName:String? {
         
         get{
             return objc_getAssociatedObject(self, &EnNameKey) as? String
         }
     
         set{
             objc_setAssociatedObject(self, &EnNameKey, "你的英文名字", objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
         }
         
     }
 }

 48.谈谈看对Xcode你有多少理解。
 iOS开发IDE是Xcode，它是apple开发的主流工具，目前Xcode已经更新到了11个版本。 Version 11.5 (11E608c)
 功能蕴含了开发、测试、性能分析、文档查询、源代码管理等多方面功能。

 C、C++与Objective-C密不可分，
 自动化用Ruby，熟悉的工具：fastlane、cocoapods、Automation工具的脚本大多是用javaScript，
 刚发布的coreML采用的模型工具则是用Python开发的。最新的Xcode采用完全由Swift重写的Source Editor，在代码修改、补全、模拟器运行方面有了很大的提升，目前，Xcode最大的缺点是稳定性还不够。

 Xcode工具想用的熟练，则必须从Intruments性能分析和LLDB调试，一步一步进行由浅入深、Swift最新的Playground也是一个不错的工具。

 49.LLDB中的p和po的区别
 p是exor的缩写。它的工作是把接受到的参数在当前环境下运行编译，人后打印出对应的值。
 Po即expr-o-。操作跟p相同，如果接收的是一个指针，那么它会调用对象的description方法并打印；如果接收到的参数是一个core foundation对象，那么它会调用CFShow方法并打印，如果两个方法都调用失败，那么po打印出和p相同的内容。
 Po相对于p来说可以多打印一些内容，一般用p即可，毕竟打印的东西越少越快，效率越高。如果需要查看详情就用Po。
 
 
 50.description方法是干什么用的？
 这个是iOS对象默认的一个方法，它的输出格式一般为<类名: 对象的内存地址>
 也可以自定义这个输出格式，NSObject类所包含。

 51.Xcode中的Buildtime issues和Runtime issues指的是什么？
 Buildtime issues一般分为三类：编译器识别出的警告(Warning)、错误(Error)和静态分析(Static Code Analysis)。前两者一般经常会遇到，不用多说，静态分析也可以分为三种：1）未初始化变量，未使用数据和API使用错误。

 Swift代码：

 class CusViewController: UIViewController {
     override func viewDidLoad() {
         let PeopleList:[UserModel]
         let somePeopleList = PeopleList
         let otherPeopleList:[UserModel]?
     }
 }
 分析代码：
 PeopleList并没有初始化就去赋值给somePeopleList所以是未初始化报错。
 otherPeopleList并没有使用，那么就会出现未使用的数据，在viewDidLoad中没有使用super.viewDidLoad()那么就是Api调用错误。

 Runtime issues也有三类错误：线程问题、UI布局和渲染问题、内存问题。线程的相关问题最多，最常见的就是数据的竞争。

 var num = 0
 let addnum1 = 10,addnum2 = 100
     
 DispatchQueue.global().async {
     for _ in 0...10{
         num += addnum1
     }
 }
     
 for _ in 0...10 {
     num += addnum2
 }
 两个线程都对num进行写操作，这样的话，谁先操作，那么值就会根据方法+几 因为数据直接就存在了争抢关系，当然最终结果是一样的，但是中间的先后顺序就会打乱了。

 UI布局和渲染上面的时候尺寸设定、布局没有给全，渲染设定模糊，因而造成的autolayout无法渲染。
 内存上的问题就是内存泄漏，比如循环引用等。

 52.App启动时间过长，该怎么去优化？
 导致App启动时间过长的原因有多种，从理论上面来讲有两种情况：1）main函数加在之前；2）main还是加载之后。

 main 函数加载之前，如果想要分析这块儿的代码，
 需要去Xcode中添加DYLD_PRINT_STATISTICS环境变量，并将其值设置为1，这样就可以得到如下的启动日志：
 
 
 还有很多的静态变量，如果想查看的话，在终端man dyld会打印出你要的静态变量的列表，
 可以一个一个的去打印看看。
 例子：

 Total pre-main time: 339.26 milliseconds (100.0%) //总的时间  毫秒
          dylib loading time: 154.24 milliseconds (45.4%) //库加载
         rebase/binding time:  78.42 milliseconds (23.1%) //重定向/绑定
             ObjC setup time:  69.27 milliseconds (20.4%) //对象设置
            initializer time:  37.18 milliseconds (10.9%) //初始化
            slowest intializers :
              libSystem.B.dylib :   8.49 milliseconds (2.5%) //系统库
     libMainThreadChecker.dylib :  17.09 milliseconds (5.0%)
 //系统库

 从上面打印的内容来看，大致就是上面的四个方面： 动态库加载、重定位绑定对象、设置对象、对象的初始化。
 通过上述打印我们可以通过以下方式来优化App的启动时间：

 减少动态库的数量，动态库加载时间会减少，apple推荐 动态库数量不超过6个。

 减少Objective-C的类数量，例如合并和删除，这样可以加快动态链接，重定位/绑定耗费的时间会相应的减少。

 使用initialize方法替代load方法，或尽量将load方法中的代码延后调用。对象的初始化所耗费的时间会相应减少。

 在main之后的app启动时间主要是要优化第一个界面的渲染速度，主要是看进入Viewdidload viewwillAppear这两个方法是否有其他操作。

 53.如何检测代码中的循环引用？
 目前所了解的有两种方式：

 1） 使用Xcode中的Memory Debug Graph。
 在Xcode中运行代码，在有可能循环引用的地方添加断点，然后点击如图所示的按钮就能查看是否循环引用。


 上图中的内容，点击了这个按钮以后左边是类，右边是类图，其中谁引用了谁，这里很清楚的可以看到引用示意图。

 2） 使用Instruments里面的leaks选项--这是一个专门检测内存泄漏的工具，在进入首页以后，发现leak Checks中出现内存泄漏，就是出现小红点的时候，可以将导航栏中的选项切换到call tree模式下，如果调试自己写的代码的话，建议勾选Display Settings 中勾选 "Separate by Thread"和"Hide System Libraries"两个选项。这样可以隐藏系统和应用程序本身的调用路径，从而更方便地找出retain cycle位置。



 54.怎么解决EXC_BAD_ACCESS
 产生EXC_BAD_ACCESS的主要原因是访问了某些已经被释放掉的对象，或者访问了它们已经释放的成员变量或方法。解决方法主要有下面几种：

 设置全局断点，快速定位缺陷所在：这种方法效果一般。
 重写Object和respondsToSelector方法：这个方法效果一般，并且要在每个class上进行定点排查，所以不推荐使用该方法。
 使用Zombie和Address Sanitizer：可以在绝大多数情况下定位问题代码，


 55.如何在Playground中执行异步操作
 阅读下述代码，打印结果是什么？

 import Foundation

 let urlstr = URL.init(string: "https://api.apiopen.top/getSingleJoke")
 let task = URLSession.shared.dataTask(with: urlstr!) { (data, response, error) in
     do {
         
         let dict:NSDictionary =  try JSONSerialization.jsonObject(with: data!, options: []) as! NSDictionary
         print(dict.object(forKey: "message") as! String)
         print(dict)
     } catch {
         print(error)
     }
 } //这个是初始化任务，但是并没有执行，下面必须调用恢复，证明这个任务已经开始只不过暂停，字面意思哈。

 task.resume()  //恢复任务
 答案是：什么都不会打印出来，原因是playground在执行完所有的操作以后会自动退出，要让playground打印出异步执行的内容，需要具备延时运行的特征，所以需要在Playground中添加下述代码：

 import PlaygroundSupport

 PlaygroundPage.current.needsIndefiniteExecution = true
 56.在Playground中实现一个10行的列表，每行显示一个0～100的整数。
 啥也不说了上代码


 import UIKit
 import PlaygroundSupport

 class ViewController :UITableViewController{
     
     override func viewDidLoad() {
         super.viewDidLoad()
     }
     
 }

 extension ViewController {
     
     override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return 10
     }
     
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = UITableViewCell()
         cell.textLabel?.text = "\(Int(arc4random_uniform(100)))"
         return cell
     }
     
 }

 PlaygroundPage.current.liveView = ViewController()

 57.runtime如何实现weak变量的自动置nil？
 //问题延伸
 Weak指针不会增加所引用对象的引用计数，并且在引用对象被回收的时候自动置nil，通常解决循环引用的问题，自动置nil的原理是什么？
 
 Runtime维护了一个Weak的表，用于存储指向某个对象的所有Weak指针。
 
 Weak表就是一个hash表(哈希表)，Key是所指对象地址，Value是Weak指针的地址(这个地址的值是所指对象的地址)的数组。
 在对象被回收的时候，经过层层调用，会最终将这个Weak表中所有的Weak指针全部置nil。
 
 源码在Runtime的源码中有个文件objc-weak.mm 其中就有这段代码。
 
 /**
  * Called by dealloc; nils out all weak pointers that point to the
  * provided object so that they can no longer be used.
  *
  * @param weak_table
  * @param referent The object being deallocated.
  */
 void
 weak_clear_no_lock(weak_table_t *weak_table, id referent_id)
 {
     objc_object *referent = (objc_object *)referent_id;

     weak_entry_t *entry = weak_entry_for_referent(weak_table, referent);
     if (entry == nil) {
         /// XXX shouldn't happen, but does with mismatched CF/objc
         //printf("XXX no entry for clear deallocating %p\n", referent);
         return;
     }

     // zero out references
     weak_referrer_t *referrers;
     size_t count;
     
     if (entry->out_of_line()) {
         referrers = entry->referrers;
         count = TABLE_SIZE(entry);
     }
     else {
         referrers = entry->inline_referrers;
         count = WEAK_INLINE_COUNT;
     }
     
     for (size_t i = 0; i < count; ++i) {
         objc_object **referrer = referrers[i];
         if (referrer) {
             if (*referrer == referent) {
                 *referrer = nil;
             }
             else if (*referrer) {
                 _objc_inform("__weak variable at %p holds %p instead of %p. "
                              "This is probably incorrect use of "
                              "objc_storeWeak() and objc_loadWeak(). "
                              "Break on objc_weak_error to debug.\n",
                              referrer, (void*)*referrer, (void*)referent);
                 objc_weak_error();
             }
         }
     }
     
     weak_entry_remove(weak_table, entry);
 }

 根据对象地址，找到weak指针的数组，遍历所有数组的weak指针置nil，
 最后将这个entry从weak表中删除 weak_entry_remove(weak_table, entry);
 
 58.介绍一下GCD、NSOperation、NSTread分别是是什么？NSOperation和GCD比有哪些优缺点？
 GCD是一个基于C语言的多线程编程的解决方式。
 NSOperation是更加注重面向对象的多线程编程的解决方式。
 NSTread是一个轻量级的多线程编程方式。

 NSOperation更加抽象化，抽象化的方式可以使多线程管理并发，顺序，依赖关系时更加灵活：

 性能上：GCD接近底层，基于C语言的代码执行更加高效，理论上速度比NSOperation快
 异步队列操作上，管理顺序、依赖关系，这些面向对象的编程会更加方便去实现，而GCD在这种方式上面会更加麻烦，代码量会更多。
 日常使用上，如果是简单的异步操作回调的形式建议是GCD，简单方便，如果对一些异步操作管理过程中有更多的线程顺序、依赖关系那么建议用NSOperation
 
 59.怎么用Copy关键字
 copy一般用在NSString、NSArray、NSDictionary等属性字段的修饰符。

 因为这些属性都有与之对应可变的子类。用copy修饰的上述几个类型，在赋值的时候有坑会赋到可变的类型的指针，如果这个可变子类用strong修饰，那么一旦这个可变对象的值被修改了，那么这个对象也就被修改了，所以copy就是为了复制一份不可变的对象付给copy修饰的对象。

     //mutableString这个参数是类A的一个变量类型是NSMutableString
     NSMutableString* mutableString = [[NSMutableString alloc]initWithString:@"mutablestring"];
     
     UserModel *user = [[UserModel alloc]init];
     
     //首先将字符串赋值
     user.title = @"title";
     user.title = mutableString; //这时候title==mutableString==@"mutablestring"
     
     //修改mutableString的值
     [mutableString appendString:@"111"];
     
     //得到的结果是user.title == mutableString == @"mutablestring111"
     NSLog(@"title=%@--%p mutableString=%@--%p",user.title,user.title,mutableString,mutableString);

 最终 title在不知不觉中就被修改了。所以用copy，修饰出来的属性都是不可变的。
 在setter方法中：

 - (void)setStr:(NSString*)str
     if(_Str != str){
         [_Str release];
         _Str = [str copy];
 }

 60.什么是MVC、MVP、MVVM？MVVM的每一层关系是什么？
 MVC 是Model、View、Controller。
 View与Controller通信、Model与Controller通信 View与Model严格意义上是完全解耦合的。

 View与Controller：

 action：点击、滑动、跳转、刷新UI、网络请求等，用户与View交互触发、控制器方法
 委托delegate：View向Controller询问一些自己无法做到的事情，让Controller去解决，比如说获取数据
 数据Model：View跟Controller要需要显示的数据，Controller需要访问Model，从Model中获取数据告诉View让其显示
 Model与Controller

 广播(Notification)，Controller注册监听Model的数据变化的通知，当Model变化的时候告诉ControllerModel数据更新了
 KVO(KEY-Value-Observing):Model作为Controller的属性，Controller监听这个属性变化，当Model属性被修改时，这个Controller会接收到通知

 分离了视图层和业务层
 耦合性低
 开发速度快
 可维护性高
 MVP 是Model-View(Controller)-Presenter

 MVP模式也是一种经典的界面模式。MVP中的M代表Model, V是View, P是Presenter。在MVP里，Presenter完全把Model和View进行了分离，主要的程序逻辑在Presenter里实现。而且，Presenter与具体的View是没有直接关联的，而是通过定义好的接口(协议)进行交互，从而使得在变更View时候可以保持Presenter的不变，重用

 优点

 低耦合
 可重用性
 独立开发
 可测试
 缺点

 如果view跟Presenter的交互太过于频繁，那就会跟特定的界面过于紧密，如果视图变更，那么presenter也要跟着变更了。


 MVVM 是 Model View ViewModel

 Model：业务逻辑处理、数据控制(本地缓存、网络加载)
 View(Controller)：显示用户可见、用户交互
 ViewModel：组织View和Model的逻辑层

 View绑定到ViewModel，然后执行一些命令在向它请求一个动作。
 ViewModel跟Model通讯，反过来ViewModel在告诉View更新UI


 优点

 低耦合
 可重用性
 独立开发
 可测试
 缺点

 因为ViewModel跟Presenter不一样的是所有的数据都是协议、接口回调，而ViewModel则是数据绑定到View上面，如果是数据bug问题，很难定位到数据哪一步出错。
 在一个模块中  viewModel中如果Model的数据很大，长期不释放，这是一个不必要的花销。
 数据双向绑定不利于代码的重用，开发中常见的重用都是view，一个view中绑定一个model，不同的模块中的model不同，到时候如果只简单的重用view，Model不做任何变化的话不太现实。


 
 
 
 
 
 
 
 iOS动画
 好的应用都有一个共同的特点，那就是良好的用户体验，动画作为提升用户体验一个重要技术，在开发人员和产品设计人员手里，则应该受到足够重视。

 CoreGraphics：

 它是iOS的核心图形库，平时使用最频繁的point，size，rect等，都定义在这个框架中，类名以CG开头的都属于CoreGraphics框架，它提供的都是C语言的函数接口，是可以在ios和mac os通用的。

 QuartzCore：

 这个框架的名称感觉不是很清晰，不明确，但是看它的头文件可以发现，它其实就是CoreAnimation，这个框架的头文件只包含了CoreAnimation.h

 Core animation(核心动画)
 锚点anchorPoint
 概念
 anchorPoint是相对于自身layer，anchorPoint点(锚点)的值是用相对bounds的比例值来确定的。
 anchorPoint相当于支点，可以用作旋转变化、平移、缩放，如果修改anchorPoint则layer的frame会发生改变，position不会发生改变.
 修改position与anchorPoint中任何一个属性都不影响另一个属性.
 单位：
 0～1
 anchorPoint和position的关系
 anchorPoint和position不是一个点
 anchorPoint和position和frame的三条关系
 第一条关系说明：锚点不变时，frame改变，position会随着变化
 第二条关系说明：锚点不变时，position变化，frame会随着变化
 第三条关系说明：锚点改变， position不影响，frame会随着变化
 创建动画的三个步骤
 创建核心动画大致分为三个步骤：
 初始化动画对象
 设置需要修改动画的属性值
 把动画添加到layer上
 隐式动画和显示动画
 当动画完成以后你看到的都是假象，你的view并没有变化，layer分为两层：

 presentationlayer 呈现成
 凡是眼睛看到的都是呈现层
 modelayer 模型层
 用来存储数据，等到屏幕需要刷新的时候绘制到呈现层
 显示动画
 通过自定义三步骤的动画都是显示动画
 隐式动画
 通过自创建的layer，修改其属性会默认添加一些动画效果，这些动画效果就是隐式动画
 CALayer 默认时间 0.25s(位置、颜色、大小)
 必须是独立的CALayer才有隐式动画， UIView的根layer是没有的
 例如代码如下：


 _layer = [CALayer layer];
 _layer.frame = CGRectMake(200, 100, 100, 100);
 //可移值性
 _layer.backgroundColor = [UIColor yellowColor].CGColor;
 [self.view.layer addSublayer:_layer];

 _layer.frame = CGRectMake(200, 400, 100, 100);

 iOS动画框架结构
 CoreAnimation.png
 在iOS系统中给我们提供了基于Core animation这几种动画，如下图所示:


 CABasicAnimation(基础动画)
 CABasicAnimation的属性
 属性    说明
 duration    动画的时长
 repeatCount    重复的次数
 repeatDuration    设置动画的时间，在改时间内一直执行，不计算次数
 beginTime    指定动画开始时间
 timingFunction    设置动画的速度变化
 autoreverses    动画结束是否执行逆动画
 fromValue    属性的起始值
 toValue    结束的值
 byValue    改变属性相同起始值的改变量
 CABasicAnimation的Keypath属性
 apple官网动画属性

 如下常用的属性：

 Keypath    说明    使用
 transform.scale    比例转化    @(cgfloat)
 transform.scale.x    宽的比例    @(cgfloat)
 transform.scale.y    高的比例    @(cgfloat)
 transform.rotation.x    围绕x轴旋转    @(M_PI)
 transform.rotation.y    围绕y轴旋转    @(M_PI)
 transform.rotation.z    围绕z轴旋转    @(M_PI)
 cornerRadius    圆角的设置    @(50)
 backgroundColor    背景颜色的变化    (id)[uicolor redcolor].cgcolor
 bounds    大小，中心不变    [nsvalue valuewithcgrect:]
 position    位置(中心点的改变)    [nsvalue valuewithcgpoint]
 contents    内容(比如图片)    (id)image.cgimage
 opacity    透明度    @(cgfloat)
 contentsRect.size.width    横向拉伸缩放(需要设置contents)    @(cgfloat)
 CABasicAnimation的例子
 做一个从上往下走的动画

 CABasicAnimation *basicani = [CABasicAnimation animationWithKeyPath:@"position.y"];//中心点
 basicani.toValue = @400;
 basicani.duration = 2;
 //动画完成不移除状态
 basicani.removedOnCompletion = NO;
 //保持最后的状态
 basicani.fillMode = kCAFillModeForwards;
 basicani.delegate = self;
 [_RedView.layer addAnimation:basicani forKey:@""];
 CAKeyframeAnimation关键帧动画
 CAKeyframeAnimation设置动画的路径分为两种

 设置path
 设置一组的values
 CAKeyframeAnimation的例子
 代码如下：设置了一个飞机按照轨迹飞行的动画

 //贝塞尔曲线
 /*
  想要通过程序写曲线或者不规则的图形时，是很复杂的
  贝塞尔曲线就是通过代码转换成公式来进行绘制的。
  
  起点
  终点
  2个控制点
  **/
 UIBezierPath *path = [UIBezierPath bezierPath];
 [path moveToPoint:CGPointMake(20, 200)];
 [path addCurveToPoint:CGPointMake(300, 200) controlPoint1:CGPointMake(100, 100) controlPoint2:CGPointMake(200, 300)];
     
 CALayer *planelayer = [CALayer layer];
 planelayer.backgroundColor = [UIColor redColor].CGColor;
 planelayer.frame = CGRectMake(0, 0, 40, 40);
 planelayer.anchorPoint = CGPointMake(0.5, 0.8);
 planelayer.contents = (id)[UIImage imageNamed:@"feiji"].CGImage;
 [self.view.layer addSublayer:planelayer];
     
 //需要添加到layer上
 //形状图 矢量图 这个事layer的子类，CAShapeLayer有一个硬件加速更快
 CAShapeLayer *shapelayer = [CAShapeLayer layer];
 shapelayer.path = path.CGPath;
 shapelayer.fillColor = nil;  //填充颜色
 shapelayer.strokeColor = [UIColor blueColor].CGColor;//画笔的颜色
 [self.view.layer addSublayer:shapelayer];
     
 /*
  CAKeyframeAnimation 设置动画的路径分为两种：
  1. 设置path
  2. 设置一组values
  ***/
     
 //飞行动画
 CAKeyframeAnimation *planeAni = [CAKeyframeAnimation animation];
 planeAni.keyPath = @"position";
 planeAni.path = path.CGPath;
 planeAni.rotationMode = kCAAnimationRotateAuto;
 planeAni.duration = 3.5;
 planeAni.fillMode = kCAFillModeForwards;
 planeAni.removedOnCompletion = NO;
 [planelayer addAnimation:planeAni forKey:@"planeAni"];
 CAAnimationGroup动画组
 将多个动画合并到一起的动画就是CAAnimationGroup动画组

 CAAnimationGroup例子
 UIBezierPath *path = [UIBezierPath bezierPath];
 [path moveToPoint:CGPointMake(20, 200)];
 [path addCurveToPoint:CGPointMake(300, 200) controlPoint1:CGPointMake(100, 100) controlPoint2:CGPointMake(200, 300)];
     
 CALayer *colorlayer = [CALayer layer];
 colorlayer.frame = CGRectMake(0, 0, 60, 60);
 colorlayer.position = CGPointMake(50, 200);
 colorlayer.backgroundColor = [UIColor yellowColor].CGColor;
 [self.view.layer addSublayer:colorlayer];

 //飞行动画
 CAKeyframeAnimation *planeAni = [CAKeyframeAnimation animation];
 planeAni.keyPath = @"position";
 planeAni.path = path.CGPath;
 planeAni.rotationMode = kCAAnimationRotateAuto;
     
 //改变大小
 CABasicAnimation *sizeanim = [CABasicAnimation animation];
 sizeanim.keyPath = @"transform.scale";
 sizeanim.toValue = @0.5;

 //改变颜色
 CGFloat redcolor = arc4random() % 255 / 255.0f;
 CGFloat greencolor = arc4random() % 255 / 255.0f;
 CGFloat bluecolor = arc4random() % 255 / 255.0f ;
 UIColor *color = [UIColor colorWithRed:redcolor green:greencolor blue:bluecolor alpha:1];
     
 CABasicAnimation *colorAnim = [CABasicAnimation animation];
 colorAnim.keyPath = @"backgroundColor";
 colorAnim.toValue = (id)color.CGColor;
     
 CAAnimationGroup *group = [CAAnimationGroup animation];
 group.animations = @[planeAni, sizeanim, colorAnim];
 group.duration = 4.0f;
 group.fillMode = kCAFillModeForwards;
 group.removedOnCompletion = NO;
 [colorlayer addAnimation:group forKey:nil];
 转场动画
 CATransition转场动画
 CATransition是CAAnimation的子类，用于过渡动画或转场动画。为视图层移入移除屏幕提供转场动画。

 简单的转场动画ImageView的切换：


 @property (weak, nonatomic) IBOutlet UIImageView *ImageView;
 @property (strong,nonatomic)NSArray *images;
 @property (assign,nonatomic)NSInteger index;


 - (void)Createtransition{
     
     if(_index == 3){
         _index = 0;
     }
     _index ++ ;
     NSString *imagename = _images[_index];
     _ImageView.image = [UIImage imageNamed:imagename];
     CATransition *anima = [CATransition animation];
     anima.type = @"cube";
     [_ImageView.layer addAnimation:anima forKey:@"CATransitionkey"];
     
     
 }
 _images = @[@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg"];
 _index = 0;

 [self Createtransition];

 转场动画的重要属性
 type：系统自带转场动画的类型

 官方自定
 CA_EXTERN NSString * const kCATransitionFade;
 CA_EXTERN NSString * const kCATransitionMoveIn;
 CA_EXTERN NSString * const kCATransitionPush;
 CA_EXTERN NSString * const kCATransitionReveal;
 私有的type：
 NSString *const kCATransitionCube = @"cube";
 NSString *const kCATransitionSuckEffect = @"suckEffect";
 NSString *const kCATransitionOglFlip = @"oglFlip";
 NSString *const kCATransitionRippleEffect = @"rippleEffect";
 NSString *const kCATransitionPageCurl = @"pageCurl";
 NSString *const kCATransitionPageUnCurl = @"pageUnCurl";
 NSString *const kCATransitionCameraIrisHollowOpen = @"cameraIrisHollowOpen";
 NSString *const kCATransitionCameraIrisHollowClose = @"cameraIrisHollowClose";
 subtype:动画类型的方向

 CA_EXTERN NSString * const kCATransitionFromRight;
 CA_EXTERN NSString * const kCATransitionFromLeft;
 CA_EXTERN NSString * const kCATransitionFromTop;
 CA_EXTERN NSString * const kCATransitionFromBottom;
 transitionFromViewController
 转场动画的type
 UIViewAnimationOptionTransitionNone            = 0 << 20, // default
 UIViewAnimationOptionTransitionFlipFromLeft    = 1 << 20,
 UIViewAnimationOptionTransitionFlipFromRight   = 2 << 20,
 UIViewAnimationOptionTransitionCurlUp          = 3 << 20,
 UIViewAnimationOptionTransitionCurlDown        = 4 << 20,
 UIViewAnimationOptionTransitionCrossDissolve   = 5 << 20,
 UIViewAnimationOptionTransitionFlipFromTop     = 6 << 20,
 UIViewAnimationOptionTransitionFlipFromBottom  = 7 << 20,
 AViewController *a = self.childViewControllers[0];
 BViewController *b = self.childViewControllers[1];
 CViewController *c = self.childViewControllers[2];

 [self transitionFromViewController:_currentViewController
                   toViewController:b
                           duration:0.5
                            options:UIViewAnimationOptionTransitionFlipFromRight
                         animations:^{

 } completion:^(BOOL finished) {

 }];
 Transition Animation(自定义转场动画)
 第一种：presented& Dismiss
 需要实现UIViewController中的UIViewControllerTransitioningDelegate协议，实现下面两个API：

 //presented会调用的方法
 - (nullable id <UIViewControllerAnimatedTransitioning>) v:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source;
 //Dismiss会调用的方法
 - (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
 第二种：Push&Pop

 需要实现navigationController中的UINavigationControllerDelegate协议，实现下面一个API:

 - (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                             animationControllerForOperation:(UINavigationControllerOperation)operation
                                                          fromViewController:(UIViewController *)fromVC
                                                            toViewController:(UIViewController *)toVC{

 上述API的返回值id <UIViewControllerAnimatedTransitioning>就是我们需要自定义的动画

 自定义转场动画步骤：

 创建一个NSObject的对象

 核心：遵守<UIViewControllerAnimatedTransitioning>

 实现下面2个方法：

 //动画持续时间，单位是秒
 - (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
 }

 //动画效果
 - (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
 }
 在animateTransition方法中实现你的动画

 动画结束后调用completeTransition告诉系统转场动画结束

 自定义转场动画的核心思想

 containerView 动画的容器
 ToVC
 FromVC
 mask
 completeTransition动画完成
 Push&Pop形式转场动画
 自定义转场动画入口:

 在Push和Pop的ViewController遵守UINavigationControllerDelegate协议

 实现下面方法,并返回自定义动画：

 <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                             animationControllerForOperation:(UINavigationControllerOperation)operation
                                                          fromViewController:(UIViewController *)fromVC
                                                            toViewController:(UIViewController *)toVC{
     
     if(operation == UINavigationControllerOperationPush){
         //Push
         return 返回你的自定义动画
     }
     if(operation == UINavigationControllerOperationPop){
         //Pop
         return 返回你的自定义动画
     }
     return nil;
 }
 自定义转场动画实现代码：

 //Pop
 - (void)CreatePopAnimation:(id <UIViewControllerContextTransitioning>)transitionContext{
     
     UIViewController * fromVC   = [_context viewControllerForKey:UITransitionContextFromViewControllerKey];
     UIViewController *toVC      = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
     UIView *containerView       = [transitionContext containerView];
     [containerView addSubview:toVC.view];
     [containerView addSubview:fromVC.view];

     maskLayer.path              = SmallPath.CGPath;
     fromVC.view.layer.mask      = maskLayer;
     
     CABasicAnimation *anim      = [CABasicAnimation animation];
     anim.keyPath                = @"path";
     anim.fromValue              = (__bridge id _Nullable)(BigPath.CGPath);
     anim.toValue                = (__bridge id)(SmallPath.CGPath);
     anim.duration               = [self transitionDuration:_context];
     anim.timingFunction         = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
     anim.delegate               = self;
     [maskLayer addAnimation:anim forKey:nil];
     
 }

 //push
 - (void)CreatePushAnimation:(id <UIViewControllerContextTransitioning>)transitionContext{
     
     UIViewController *toVC      = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
     UIView *containerView       = [transitionContext containerView];
     [containerView addSubview:toVC.view];

     maskLayer.path              = BigPath.CGPath;
     toVC.view.layer.mask        = maskLayer;

     CABasicAnimation *anim      = [CABasicAnimation animationWithKeyPath:@"path"];
     anim.fromValue              = (__bridge id)(SmallPath.CGPath);
     anim.toValue                = (__bridge id)((BigPath.CGPath));
     anim.duration               = [self transitionDuration:_context];
     anim.timingFunction         = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
     anim.delegate               = self;
     [maskLayer addAnimation:anim forKey:nil];
 }
 Presentation&Dismiss形式转场动画
 自定义转场动画入口:

 present后的视图ToVC遵守UIViewControllerTransitioningDelegate协议
 self.transitioningDelegate = self;
 self.modalPresentationStyle = UIModalPresentationCustom;
 实现下面方法,并返回自定义动画：
 - (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
 }

 - (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
 }
 自定义动画代码实现

 //dissmiss
 - (void)CreateDismissAnimation:(id <UIViewControllerContextTransitioning>)transitionContext{
     
     UIView* containerView   = [transitionContext containerView];
     TwoVC * fromVC          = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
      [containerView addSubview:fromVC.view];
     
     maskLayer.path              = SmallPath.CGPath;
     fromVC.view.layer.mask      = maskLayer;

     CABasicAnimation *anim      = [CABasicAnimation animation];
     anim.keyPath                = @"path";
     anim.fromValue              = (__bridge id _Nullable)(BigPath.CGPath);
     anim.toValue                = (__bridge id _Nullable)(SmallPath.CGPath);
     anim.duration               = [self transitionDuration:_context];
     anim.timingFunction         = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
     anim.delegate               = self;
     [maskLayer addAnimation:anim forKey:nil];
   
 }

 //Presentation
 - (void)CreatePresentationAnimation:(id <UIViewControllerContextTransitioning>)transitionContext{
     
     UIViewController *toVC      = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
     toVC.view.frame             = CGRectMake(0, 0, GGScreenwidth, GGScreenheight);
     UIView *containerView       = [transitionContext containerView];
     [containerView addSubview:toVC.view];
     
     maskLayer.path              = BigPath.CGPath;
     toVC.view.layer.mask        = maskLayer;

     CABasicAnimation *anim      = [CABasicAnimation animation];
     anim.keyPath                = @"path";
     anim.fromValue              = (__bridge id _Nullable)(SmallPath.CGPath);
     anim.toValue                = (__bridge id _Nullable)(BigPath.CGPath);
     anim.duration               = [self transitionDuration:_context];
     anim.timingFunction         = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
     anim.delegate               = self;
     [maskLayer addAnimation:anim forKey:nil];
 }

 
 
 61：谈谈iOS内存
 
 61.1: 内存区域划分
 iOS进程内存布局从高地址往低地址分位几个区块：

 1.栈区域
 2.堆区域
 3.未初始化静态、全局数据       (存放程序中未初始化)
 4.已初始化静态、全局数据       (存放程序静态分配的变量和全局变量)
 5.常量区                    (存放程序常量)
 6.代码区                    (存放程序代码)

 栈： 栈是由编译器Mac自动分配并释放

 通常是用户存放临时创建的局部变量，存放函数的参数值，局部变量等
 通常包括在"{}"中创建的变量，不包含static修饰的变量
 通常函数参数，以及函数返回值也是会被分配到栈中
 通常alloc的对象，对象指针在栈中，而对象本身地址在堆中
 我的理解就是栈是一个临时数据寄存、交换的区域
 堆： 堆是由程序员分配和释放，通常用alloc等函数分配的对象

 用于存放程序运行中被动态分配的内存段，它的大小并不固定，可动态扩张或缩减
 在OC中对象通常指在一块特定布局的连续内存区域
 用alloc等函数分配内存时,新分配的内存就被动态添加到堆上(堆被扩张)
 在OC中通常用retain保存对象引用计数，release释放对象(堆被缩减)
 通常alloc的对象，对象指针在栈中，而实际对象实现地址在堆中
 常量区： 用于存放常量字符串，程序结束后由系统释放

 全局区： 用于存放程序静态分配的变量和全局变量 细分2种

 未初始化静态、全局数据
 已初始化静态、全局数据
 代码区： 用于存放函数的二进制代码

 代码段需要防止在运行时中被非法修改，所以只准读不准写
 61.2: 内存管理
 61.2.1: 引用计数
 在iOS中使用了"引用计数"来管理内存，指将资源的被引用次数保存起来，当被引用次数变为0的时候该对象就会被释放。

 当创建一个对象A的实例并在堆上申请完内存，对象A的引用计数为1，在其他对象B持有这个对象A时，就需要把对象A的引用计数+1，持有者需要释放对象A的时候，引用计数-1，当最后对象A的引用计数为0时，对象的内存会被释放。

 iOS在xcode4.2版本之前一直是使用的是MRC(手动引用计数)，当xcode4.2版本之后就使用了ARC(自动引用计数)

 61.2.2 MRC(Manual Retain Count)
 在MRC中管理内存的引用计数，全部都是手动完成的，所以我们需要知道哪些是初始化为1，哪些是+1，哪些是-1

 61.2.2.1 影响引用计数的方式：
 对象操作    对应方法    引用计数变化
 生成并持有对象    alloc、new、copy、mutablecopy    1
 持有对象    retain    +1
 释放对象    release    -1
 延迟释放对象    autorelease    -1
 新的对象
 alloc、new、copy、mutablecopy都会创建一个新的对象，那么新的对象则是引用计数为1
 retain 引用计数 +1
 release 引用计数 -1
 autorelease 将代码放入到自动释放池中，当代码运行完成以后，所有调用autorelease的对象调用relrese
 61.2.2.2 MRC管理的四法则
 1 . 自己生成并自己持有

 /*
  * 自己生成并持有该对象
  */
  id obj0 = [[NSObeject alloc] init];
  id obj1 = [NSObeject new];
 2 . 非自己生成的对象，自己也能持有

 /*
  * 持有非自己生成的对象
  */
 id obj = [NSArray array]; // 非自己生成的对象，且该对象存在，但自己不持有
 [obj retain]; // 自己持有对象
 3 . 不再需要自己持有对象的时候，释放

 /*
  * 不在需要自己持有的对象的时候，释放
  */
 id obj = [[NSObeject alloc] init]; // 此时持有对象
 [obj release]; // 释放对象
 /*
  * 指向对象的指针仍就被保留在obj这个变量中
  * 但对象已经释放，不可访问
  */
  [obj method];  //崩溃
 4 . 非自己持有的对象无法释放

 /*
  * 非自己持有的对象无法释放
  */
 id obj = [NSArray array]; // 非自己生成的对象，且该对象存在，但自己不持有
 [obj release]; // 此时将运行时crash 或编译器报error

 //非自己生成的对象，且该对象存在，但自己不持有,这个特性是使用autorelease实现的
 - (id) getAObjNotRetain {
     id obj = [[NSObject alloc] init]; // 自己生成并持有该对象
     [obj autorelease]; // 取得的对象存在，但自己不持有该对象
     return obj;
 }

 61.2.3 ARC(Automatic Retain Count)
 ARC是自动引用计数，也就是说编译器在编译的时候自动在已有的代码中插入合适的内存管理代码

 目前iOS开发基本上都是基于ARC的编程，开发人员在大部分情况下不需要考虑内存管理，因为编译器已经帮你做了。

 在ARC中会经常出现的一个问题循环引用问题。

 61.2.3.1 ARC中的所有权修饰符
 strong
 weak
 unsafe_unretaied
 __autoreleasing
 所有权修饰符对应属性修饰符

 对应关系    所有权修饰符    属性修饰符
 -    __strong    strong
 -    __strong    copy
 -    __strong    retain
 -    __unsafe_unretaied    unsafe_unretaied
 -    __weak    weak
 -    __unsafe_unretained    assign
 __strong

 表示引用为强引用。对应在定义property时的"strong"。
 所有对象只有当没有任何一个强引用指向时，才会被释放。
 注意：如果在声明引用时不加修饰符，那么引用将默认是强引用。当需要释放强引用指向的对象时，需要将强引用置nil。
 __weak表示引用为弱引用。

 对应在定义property时用的"weak"。
 弱引用不会影响对象的释放，即只要对象没有任何强引用指向，即使有100个弱引用对象指向也没用，该对象依然会被释放。不过好在，对象在被释放的同时，指向它的弱引用会自动被置nil，这个技术叫zeroing weak pointer,这样有效得防止无效指针、野指针的产生。
 __weak一般用在delegate关系中防止循环引用或者用来修饰指向由Interface Builder编辑与生成的UI控件。
 __autoreleasing表示在autorelease pool中自动释放对象的引用，和MRC时代autorelease的用法相同。

 定义property时不能使用这个修饰符，任何一个对象的property都不应该是autorelease型的。
 自动释放用来表示引用(id *)传递的参数，并且在返回时自动释放。
 一个常见的误解是，在ARC中没有autorelease，因为这样一个“自动释放”看起来好像有点多余。这个误解可能源自于将ARC的“自动”和autorelease“自动”的混淆。其实你只要看一下每个iOS App的main.m文件就能知道，autorelease还是存在的存在的，不需要再手工被创建，也不需要再显式得调用[drain]方法释放内存池。
 int main(int argc, char * argv[]) {
     @autoreleasepool {
         return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
     }
 }
 __autoreleasing需要注意的地方1

 当定义了一个方法：

 - (void)doWithError:(NSError **)outError;
 上述方法，ARC模式下会自动编程如下代码

 - (void)doWithError:(NSError * __autoreleasing *)outError;
 error指向的对象在创建出来后，被放入到了autoreleasing pool中，等待使用结束后的自动释放，函数外error的使用者并不需要关心*error指向对象的释放。

 __autoreleasing需要注意的地方2

 - (void)loopThroughDictionary:(NSDictionary *)dict error:(NSError **)error
 {
     [dict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop){

           // do stuff
           if (there is some error && error != nil)
           {
                 *error = [NSError errorWithDomain:@"MyError" code:1 userInfo:nil];
           }

     }];
 }
 会隐式地创建一个autorelease pool，上面代码实际类似于：

 - (void)loopThroughDictionary:(NSDictionary *)dict error:(NSError **)error
 {
     [dict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop){

           @autoreleasepool  // 被隐式创建
 　　　　　　{
               if (there is some error && error != nil)
               {
                     *error = [NSError errorWithDomain:@"MyError" code:1 userInfo:nil];
               }
           }
     }];

     // *error 在这里已经被dict的做枚举遍历时创建的autorelease pool释放掉了 ：(
 }
 为了能够正常的使用*error，我们需要一个__block型的临时引用，在dict的枚举Block中是用这个临时引用，保证引用指向的对象不会在出了dict的枚举Block后被释放，正确的方式如下

 - (void)loopThroughDictionary:(NSDictionary *)dict error:(NSError **)error
 {
 　　__block NSError* tempError; // 加__block保证可以在Block内被修改
 　　[dict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop)
 　　{
 　　　　if (there is some error)
 　　　　{
 　　　　　　*tempError = [NSError errorWithDomain:@"MyError" code:1 userInfo:nil];
 　　　　}

 　　}]

 　　if (error != nil)
 　　{
 　　　　*error = tempError;
 　　}
 }
 在ARC与MRC当中使用autorelease

 //ARC 下  释放了内存
 NSString *__autoreleasing str1;
 @autoreleasepool {
     str1 = [[NSString alloc] initWithFormat:@"hehe2321321312213"]; // ARC
 }
 NSLog(@"%@",str1);  //崩溃

 //MRC 下  释放了内存
 NSString * str1;
 @autoreleasepool {
     str1 = [[[NSString alloc] initWithFormat:@"hehe2321321312213"]autorelease]; // MRC
 }
 NSLog(@"%@",str1);  //崩溃

 61.2.3.2 ARC中的属性标示符
 @property(assign/retain/strong/weak/unsafe_unretained/copy)NSObject *object;
 assign 表示setter仅仅是一个简单的赋值操作，通常用于基本的数值类型，例如CGFloat和NSInteger等

 strong 属性定义了强引用关系，当这个属性设置一个新值的时候：首先对新值retain，对旧值release，然后再赋值。

 weak 属性定义了弱引用关系，当给属性设置一个新值的时候，只是跟assign一样简单的赋值，如果当属性指向的对象销毁的时候，该属性会被置nil

 unsafe_unretained 也是定义了一个弱引用关系，与weak类似，不同点是unsafe_unretained修饰的属性，指向的对象如果释放，本属性不会置nil

 copy 类似于strong，不过在赋值时进行copy操作而不是retain操作，通常用于保留某个不可变的对象，防止它的意外改变时使用

 61.2.3.3 ARC模式下对象何时被释放
 局部变量会在作用域完成以后全部使用release一遍，也就是说过了作用域，这个临时变量将被释放
 ARC模式下变量的默认所有权修饰符是__strong,当变量的强引用指向一个都没有时，该对象被释放(也可以说是它的引用计数为0时)
 ARC模式下在非Alloc、new、copy、mutablecopy创建的对象时，在这些工厂方法的返回值都会自动添加到autoreleasepool中
 Autorelease返回值的快速释放机制，在ARC模式下：
 在工厂方法生成的对象，返回值会调用objc_autoreleaseReturnValue方法，代替我们调用autorelease
 调用该工厂方法的对象中，会实现objc_retainAutoreleasedReturnValue(工厂方法)代替retain
 在使用完成以后系统会自动添加objc_storeStrong(&创建的对象，nil)代理实现release
 通过pthread的线程存储技术，以工厂方法为key返回值为value存储，最终objc_autoreleaseReturnValue存value，objc_retainAutoreleasedReturnValue获取值，最后得到的数值没有进行内存管理。
 61.2.4 AutoreleasePool(自动释放池)
 61.2.4.1 AutoreleasePool基本概念
 什么是AutoreleasePool？
 AutoreleasePool是自动释放池，更灵活的管理内存
 AutoreleasePool什么时候释放？
 自动释放池释放的时候可以自动将池子中的对象release一边
 为什么要使用AutoreleasePool
 在循环当中我们需要创建很多的临时对象，每次循环都不会去释放临时对象，慢慢就会增加内存占用
 在生成辅助线程时，我们需要自己创建自动释放池，否则会泄漏对象
 61.2.4.2 @autoreleasepool底层实现
 首先从中间代码入手，使用下面命令来得到C++代码

 int main(int argc, char * argv[]) {
     @autoreleasepool {
         return 0;
     }
 }
 这里我直接用main.m文件进行分析
 clang -rewrite-objc main.m
 得到的C++代码：

 只看有关代码

 extern "C" __declspec(dllimport) void * objc_autoreleasePoolPush(void);
 extern "C" __declspec(dllimport) void objc_autoreleasePoolPop(void *);

 struct __AtAutoreleasePool {
   __AtAutoreleasePool() {atautoreleasepoolobj = objc_autoreleasePoolPush();}
   ~__AtAutoreleasePool() {objc_autoreleasePoolPop(atautoreleasepoolobj);}
   void * atautoreleasepoolobj;
 };

 #define __OFFSETOFIVAR__(TYPE, MEMBER) ((long long) &((TYPE *)0)->MEMBER)
 int main(int argc, char * argv[]) {

     /* @autoreleasepool */ { __AtAutoreleasePool __autoreleasepool;
         return 0;
     }
 }

 从上面内容我们可以看到main函数中声明了一个__AtAutoreleasePool对象，相当于调用了objc_autoreleasePoolPush()函数，该函数的作用就是向堆栈中压入一个"自动释放池"，当main函数执行完成以后，则执行__AtAutoreleasePool的析构函数objc_autoreleasePoolPop(atautoreleasepoolobj)，用于释放"自动释放池"，

 如上述所说，拼装成一个伪代码

 int main(int argc, char * argv[]) {
     /* @autoreleasepool */ {
         //创建自动释放池
         __AtAutoreleasePool __autoreleasepool = objc_autoreleasePoolPush();
         //TODO 执行各种操作，将对象加入自动释放池
         
         //释放自动释放池
         objc_autoreleasePoolPop(__autoreleasepool)
     }
 }
 61.2.4.3 AutoreleasePool本质
 在苹果开放源码中我们可以找到AutoreleasePool的底层实现
 objc_autoreleasePoolPush()以及objc_autoreleasePoolPop(__autoreleasepool)的实现如下：

 void *
 objc_autoreleasePoolPush(void)
 {
     return AutoreleasePoolPage::push();
 }

 void
 objc_autoreleasePoolPop(void *ctxt)
 {
     AutoreleasePoolPage::pop(ctxt);
 }
 从源码中我们可以发现，AutoreleasePoolPage才是AutoreleasePool的实现对象所在，找到AutoreleasePoolPage，如下代码：

 class AutoreleasePoolPage
 {
 #   define EMPTY_POOL_PLACEHOLDER ((id*)1)

 #   define POOL_BOUNDARY nil
     static pthread_key_t const key = AUTORELEASE_POOL_KEY;
     static uint8_t const SCRIBBLE = 0xA3;  // 0xA3A3A3A3 after releasing
     static size_t const SIZE =
 #if PROTECT_AUTORELEASEPOOL
         PAGE_MAX_SIZE;  //4096  必须是多个vm页面大小
 #else
         PAGE_MAX_SIZE;  //4096   大小和对齐，功率为2
 #endif
     static size_t const COUNT = SIZE / sizeof(id);

     magic_t const magic;    //数据校验
     id *next;               //栈顶地址，默认创建一个新的AutoreleasePoolPage对象的时候next是nil
     pthread_t const thread; //所在线程
     AutoreleasePoolPage * const parent;  //父对象
     AutoreleasePoolPage *child;          //子对象
     uint32_t const depth;
     uint32_t hiwat;
     ...
 }
 去除不必要的代码我们可以看到，通过这个结构体我们可以了解到AutoreleasePool实质上是若干个AutoreleasePoolPage组成的双向链表

 61.2.4.4 AutoreleasePoolPage工作原理
 创建AutoreleasePoolPage

 在void *objc_autoreleasePoolPush(void)中实际上调用了AutoreleasePoolPage::push()函数，代码如下

 static inline void *push()
 {
     id *dest;
     if (DebugPoolAllocation) {
           //当自动释放池出现顺序错误时停止，并允许堆调试器跟踪自动释放池的时候调用
         // 每个自动释放池都从一个新的池页面开始。
         dest = autoreleaseNewPage(POOL_BOUNDARY);
     } else {
         //代码正常运行时调用
         dest = autoreleaseFast(POOL_BOUNDARY);
     }
     assert(dest == EMPTY_POOL_PLACEHOLDER || *dest == POOL_BOUNDARY);
     return dest;
 }
 static inline id *autoreleaseFast(id obj)
 {
     AutoreleasePoolPage *page = hotPage(); //得到hotPage对象
     if (page && !page->full()) {
     //这个对象存在 且没有满的时候调用
         return page->add(obj);
     } else if (page) {
     //这个AutoreleasePoolPage对象存在  AutoreleasePoolPage已经满了以后调用
         return autoreleaseFullPage(obj, page);
     } else {
         //这个AutoreleasePoolPage对象不存在时调用
         return autoreleaseNoPage(obj);
     }
 }


 /*
  *  得到当前线程中所使用的AutoreleasePoolPage
  **/
  
 static pthread_key_t const key = AUTORELEASE_POOL_KEY;
  
 static inline AutoreleasePoolPage *hotPage()
 {
      //根据线程为key找到这个线程中的AutoreleasePoolPage对象
     AutoreleasePoolPage *result = (AutoreleasePoolPage *)
         tls_get_direct(key);
     if ((id *)result == EMPTY_POOL_PLACEHOLDER) return nil;
     if (result) result->fastcheck();
     return result;
 }


 /*
  * 当前hotPage存在并且没有满，
  **/
 id *add(id obj)
 {
     assert(!full());
     unprotect();
     id *ret = next;  // faster than `return next-1` because of aliasing
     *next++ = obj;
     protect();
     return ret;
 }

 /*
  *  这个AutoreleasePoolPage对象存在  AutoreleasePoolPage已经满了以后调用
  **/

 static __attribute__((noinline))
 id *autoreleaseFullPage(id obj, AutoreleasePoolPage *page)
 {
     //如果hotpage满了以后查找下一个page直到找不到，没有满的page那么就新建一个page，然后将对象添加到该页，并设置其为hotPage
     assert(page == hotPage());
     assert(page->full()  ||  DebugPoolAllocation);

     do {
         if (page->child) page = page->child;
         else page = new AutoreleasePoolPage(page);
     } while (page->full());

     setHotPage(page);
     return page->add(obj);
 }



 /*
  * //这个AutoreleasePoolPage对象不存在时调用
  **/
 static __attribute__((noinline))
 id *autoreleaseNoPage(id obj)
 {
     // We are pushing an object or a non-placeholder'd pool.

     // Install the first page.
     AutoreleasePoolPage *page = new AutoreleasePoolPage(nil);
     setHotPage(page);
         
     // Push the requested object or pool.
     return page->add(obj);
 }

 大致逻辑：

 本质上AutoreleasePool是底层是调用了AutoreleasePoolpage结构体中的push方法，而push方法调用的是Autoreleasefast。

 如果第一次hotPage()为NULL，那么调用autoreleaseNoPage(obj)新建一个parent=NULL的AutoreleasePoolPage对象做为自动释放池加入栈中，并将其设置为hotPage，最后返回给main()函数中的 __AtAutoreleasePool __autoreleasepool变量,

 hotPage()找到了正在运行的page，并且当前page并没有满那么调用add(obj)添加这个page进入到链表，并将hotpage返回给__AtAutoreleasePool __autoreleasepool变量

 hotPage()如果当前page满了，那么就会在child当中查找是否有不满的page，如果找到不满的就将这个child设置成hotPage，并调用add(obj)，如果在child中没有找到不满的page，那么就创建一个新的page然后在设置hotPage，并调用add(obj)最后将并将hotpage返回给__AtAutoreleasePool __autoreleasepool变量

 销毁AutoreleasePoolPage

 销毁这个自动释放池的方法是：

 static inline void pop(void *token)
 token 就是push()的返回值，通过该地址我们可以找到对应的page,pop()代码如下：

 static inline void pop(void *token)
 {
     AutoreleasePoolPage *page;
     id *stop;

     if (token) {
         page = pageForPointer(token); //找到所在的page地址
         stop = (id *)token; //POOL_SENTINEL的地址，从栈顶释放对象直到这个位置
     } else {
         // Token 0 is top-level pool
         page = coldPage();
         stop = page->begin();
     }

     page->releaseUntil(stop); //对自动释放池中对象调用objc_release()进行释放

     // memory: delete empty children
     // hysteresis: keep one empty child if this page is more than half full
     // special case: delete everything for pop(0)
     if (!token) {
         page->kill();
         setHotPage(NULL);
     } else if (page->child) {
         if (page->lessThanHalfFull()) {
             page->child->kill();
         }
         else if (page->child->child) {
             page->child->child->kill();
         }
     }
 }
 过程分为两部分：

 page->releaseUntil(stop)，对栈顶（page->next）到stop地址（POOL_SENTINEL）之间的所有对象调用objc_release()，进行引用计数减1；
 清空page对象page->kill()
 61.2.4.5 AutoreleasePoolPage总结
 AutoreleasePool并没有单独的结构，而是由若干个AutoreleasePoolPage以双向链表的形式组合而成（分别对应结构中的parent指针和child指针）

 AutoreleasePool是按线程一一对应的（结构中的thread指针指向当前线程）

 AutoreleasePoolPage每个对象会开辟4096字节内存（也就是虚拟内存一页的大小），除了上面的实例变量所占空间，剩下的空间全部用来储存autorelease对象的地址

 上面的id *next指针作为游标指向栈顶最新add进来的autorelease对象的下一个位置

 一个AutoreleasePoolPage的空间被占满时，会新建一个AutoreleasePoolPage对象，连接链表，后来的autorelease对象在新的page加入

 若当前线程中只有一个AutoreleasePoolPage对象，并记录了很多autorelease对象地址快满的时候，需要建立下一页page对象，与这一页链表连接完成后，新page的next指针被初始化在栈底（begin的位置），然后继续向栈顶添加新对象
 所以，向一个对象发送一个autorelease消息，就是将这个对象加入到当前AutoreleasePoolPage的栈顶next指针指向的位置

 释放
 objc_autoreleasePoolPush的返回值正是这个哨兵对象的地址，被objc_autoreleasePoolPop(哨兵对象)作为入参,

 根据传入的哨兵对象地址找到哨兵对象所处的page
 在当前page中，将晚于哨兵对象插入的所有autorelease对象都发送一次release消息，并向回移动next指针到正确位置，从最新加入的对象一直向前清理，可以向前跨越若干个page，直到哨兵所在的page
 嵌套的AutoreleasePool
 嵌套的AutoreleasePool，pop的时候总会释放到上次push的位置为止，多层的pool就是多个哨兵对象而已，就像剥洋葱一样，每次一层，互不影响。

 最后简单概括

 autoreleasepool由若干个autoreleasePoolPage类以双向链表的形式组合而成, 当程序运行到@autoreleasepool{时, objc_autoreleasePoolPush()将被调用, runtime会向当前的AutoreleasePoolPage中添加一个nil对象作为哨兵,
 在{}中创建的对象会被依次记录到AutoreleasePoolPage的栈顶指针,
 当运行完@autoreleasepool{}时, objc_autoreleasePoolPop(哨兵)将被调用, runtime就会向AutoreleasePoolPage中记录的对象发送release消息直到哨兵的位置, 即完成了一次完整的运作.

 62：iOS动态添加属性
 62.1 iOS动态添加属性
 62.1.1 使用场景
 为现有的类添加私有变量以帮助实现细节。
 为现有的类添加公有属性。
 为KVO创建一个关联的观察者。
 62.1.2 动态加添属性的相关函数
 在runtime源码的runtime.h文件中，找到它们的声明：

 //设置关联属性
 void objc_setAssociatedObject(id object,const void *key,id value,objc_AssociationPolicy policy);
 //获取关联属性
 id objc_getAssociatedObject(id object, const void *key);
 //删除所有关联属性
 void objc_removeAssociatedObjects(id object);
 objc_setAssociatedObject用于给对象添加关联对象，传入nil则可以移除已有的关联对象
 objc_getAssociatedObject用于获取关联对象
 objc_removeAssociatedObjects用于移除一个对象的所有关联对象
 参数：object对象的实例，voidkey类似对象级别唯一的一个常量，value值，关联策略*

 关键字    关联策略    对应属性修饰符
 OBJC_ASSOCIATION_ASSIGN    @property (assign) or @property (unsafe_unretained)    弱引用关联对象
 OBJC_ASSOCIATION_RETAIN_NONATOMIC    @property (strong, nonatomic)    强引用关联对象，且为非原子操作
 OBJC_ASSOCIATION_COPY_NONATOMIC    @property (copy, nonatomic)    复制关联对象，且为非原子操作
 OBJC_ASSOCIATION_RETAIN    @property (strong, atomic)    强引用关联对象，且为原子操作
 OBJC_ASSOCIATION_COPY    @property (copy, atomic)    复制关联对象，且为原子操作
 62.1.3 动态加添属性的实现
 //UserModel对象
 @interface UserModel : NSObject
 @end

 @implementation UserModel
 @end

 //在类扩展中的动态添加属性
 #import <objc/runtime.h>
 @interface UserModel(my)
 @property (nonatomic,copy)NSString *str;
 @end

 @implementation UserModel(my)
 - (NSString *)str{
     return objc_getAssociatedObject(self, _cmd);
 }
 - (void)setStr:(NSString *)str{
     objc_setAssociatedObject(self, @selector(str), str, OBJC_ASSOCIATION_COPY);
 }
 @end

 62.2 iOS动态添加属性的实现原理
 AssciationsManager 维护了一个无序的AssociationsHashMap键值哈希表
 AssociationsHashMap中有一个以object地址为key，value为objectassociationMap表的映射，
 objectassociationMap中维护了以key为key，以value为objcAssociation的映射，关联记录
 objcAssociation是一个对象，里面包含了关联的策略以及关联的值
 总结：每一个对象本身都存在一个AssciationsManager，并维护着AssociationsHashMap，AssociationsHashMap中以对象地址为key维护者一个ObjectAssociationMap，ObjectAssociationMap以key为key维护者一个objcAssociation对象，这个对象就是我们关联属性的值以及关联策略

 63: 为什么要使用taggedPointer
 假设要存储一个NSNumber对象，其值是一个整数。正常情况下，如果这个整数只是一个NSInteger的普通变量，在64位CPU下是占8个字节的。1个字节有8位，如果我们存储了一个很小的值，会出现很多位没有使用的情况，这样就造成了内存浪费，苹果为了解决这个问题，引入了taggedPointer的概念。

 首先来上一段代码：

 NSString *str1              =   @"1";
 NSString *str2              =   [NSString stringWithString:@"1"];
 NSString *str3              =   [NSString stringWithFormat:@"1"];
 NSString *str4              =   [[NSString alloc]initWithString:@"1"];
 NSString *str5              =   [[NSString alloc]initWithFormat:@"%@",str1];
 NSMutableString * str6      =   [str1 copy];
 NSMutableString * str7      =   [str1 mutableCopy];
 NSMutableString * str8      =   [[NSMutableString alloc]initWithString:@"123456"];
 [str7 appendString:@"2"];
 NSMutableString * str9      =   [str8 mutableCopy];
 [str9 appendString:@"23"];
 NSMutableString * str10     =   [str8 copy];

 打印数据：

 str1:__NSCFConstantString,0x102500060,1
 str2:__NSCFConstantString,0x102500060,1
 str3:NSTaggedPointerString,0xd11716512661ffd9,1
 str4:__NSCFConstantString,0x102500060,1
 str5:NSTaggedPointerString,0xd11716512661ffd9,1
 str6:__NSCFConstantString,0x102500060,1
 str7:__NSCFString,0x2831d82d0,12
 str8:__NSCFString,0x2831d8540,123456
 str9:__NSCFString,0x2831d80f0,12345623
 str10:NSTaggedPointerString,0xd11475026552dfde,123456

 根据上述内容我们可以发现几种字符串类型：

 NSTaggedPointerString
 __NSCFConstantString
 __NSCFString
 63.1 NSTaggedPointerString(taggedPointer)
 objc750中的taggedPointer源码分析


 extern uintptr_t objc_debug_taggedpointer_obfuscator;

 static inline void * _Nonnull
 _objc_encodeTaggedPointer(uintptr_t ptr)
 {
     return (void *)(objc_debug_taggedpointer_obfuscator ^ ptr);
 }

 static inline uintptr_t
 _objc_decodeTaggedPointer(const void * _Nullable ptr)
 {
     return (uintptr_t)ptr ^ objc_debug_taggedpointer_obfuscator;
 }

 static inline void * _Nonnull
 _objc_makeTaggedPointer(objc_tag_index_t tag, uintptr_t value)
 {
     if (tag <= OBJC_TAG_Last60BitPayload) {
         uintptr_t result =
             (_OBJC_TAG_MASK |
              ((uintptr_t)tag << _OBJC_TAG_INDEX_SHIFT) |
              ((value << _OBJC_TAG_PAYLOAD_RSHIFT) >> _OBJC_TAG_PAYLOAD_LSHIFT));
         return _objc_encodeTaggedPointer(result);
     } else {

         uintptr_t result =
             (_OBJC_TAG_EXT_MASK |
              ((uintptr_t)(tag - OBJC_TAG_First52BitPayload) << _OBJC_TAG_EXT_INDEX_SHIFT) |
              ((value << _OBJC_TAG_EXT_PAYLOAD_RSHIFT) >> _OBJC_TAG_EXT_PAYLOAD_LSHIFT));
         return _objc_encodeTaggedPointer(result);
     }
 }

 上述源码：_objc_encodeTaggedPointer是对TaggedPointer进行编码，而_objc_decodeTaggedPointer对其解码
 所以我们在iOS中只需要将NSTaggedPointerString类型的值带入到_objc_decodeTaggedPointer

 NSString *str1              =   @"1";
 NSString *str5              =   [[NSString alloc]initWithFormat:@"%@",str1];
 NSMutableString * str10     =   [str8 copy];

 NSLog(@"str5:%@,0x%lx,%@", [str5 class],_objc_decodeTaggedPointer(str5),str5);
 NSLog(@"str10:%@,0x%lx,%@", [str10 class],_objc_decodeTaggedPointer(str10),str10);
 打印结果:

 str5:NSTaggedPointerString,0xa000000000000611,a
 str10:NSTaggedPointerString,0xa000000000000611,a
 从64bit开始，iOS引入了Tagged Pointer技术，用于优化NSNumber、NSDate、NSString等小对象的存储
 在没有使用Tagged Pointer之前， NSNumber等对象需要动态分配内存、维护引用计数等，NSNumber指针存储的是堆中NSNumber对象的地址值
 使用Tagged Pointer之后，NSNumber指针里面存储的数据变成了: Tag + Data，也就是将数据直接存储在了指针中
 当指针不够存储数据时，才会使用动态分配内存的方式来存储数据
 63.1.1 如何判断是否是Tagged Pointer
 判断一个指针是否是Tagged Pointer的源码：

 static inline bool _objc_isTaggedPointer(const void * _Nullable ptr) {
     return ((uintptr_t)ptr & _OBJC_TAG_MASK) == _OBJC_TAG_MASK;
 }
 63.1.2 关于Tagged Pointer的面试题
 1.下面这段代码执行后, 会发生什么

 @property (nonatomic, copy) NSString *name;

 dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
 for (int i = 0; i < 1000; i++) {
     dispatch_async(queue, ^{
         self.name = [NSString stringWithFormat:@"abcdefghijklmn"];
     });
 }
 会崩溃，原因是在setName:方法中，实际的实现是：

 - (void)setName:(NSString *)name
 {
     if (_name != name) {
         [_name release];
         _name = [name copy];
     }
 }

 原因：

 因为使用了多线程赋值，所以会有多个线程同时调用[_name release], 所以才发触发上面的崩溃
 解决办法是开锁，或者是设置属性的原子属性atomic
 2. 下面的代码为什么可以正常运行, 不会崩溃

 @property (nonatomic, copy) NSString *name;

 dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
 for (int i = 0; i < 1000; i++) {
     dispatch_async(queue, ^{
         self.name = [NSString stringWithFormat:@"abc"];
     });
 }
 运行程序, 上面的代码确实不会发生崩溃

 这是因为[NSString stringWithFormat:@"abc"]是一个Tagged Pointer, 在调用-setName:方法时, 底层使用的是objc_msgSend(self, @selector(setName:)
 此时就会在底层调用_objc_isTaggedPointer函数判断是否是Tagged Pointer, 如果是, 就会直接将地址赋值给_name, 没有release和copy的操作
 63.2 __NSCFConstantString
 字符串常量，是一种编译时常量，它的 retainCount 值很大，是 4294967295，在控制台打印出的数值则是 18446744073709551615==2^64-1，测试证明，即便对其进行 release 操作，retainCount 也不会产生任何变化。是创建之后便是放不掉的对象。相同内容的 __NSCFConstantString 对象的地址相同，也就是说常量字符串对象是一种单例。

 这种对象一般通过字面值 @"..."、CFSTR("...") 或者 stringWithString: 方法（需要说明的是，这个方法在 iOS6 SDK 中已经被称为redundant，使用这个方法会产生一条编译器警告。这个方法等同于字面值创建的方法）产生。

 这种对象存储在字符串常量区。

 63.2 __NSCFString
 和 __NSCFConstantString 不同， __NSCFString 对象是在运行时创建的一种 NSString 子类，他并不是一种字符串常量。所以和其他的对象一样在被创建时获得了 1 的引用计数。

 通过 NSString 的 stringWithFormat 等方法创建的 NSString 对象一般都是这种类型。

 这种对象被存储在堆上。

 64 计算机位运算
 含义    运算符    例子
 左移    << 1    0011 => 0110
 右移    >> 1    0110 => 0011
 按位或(两位只要有一个为1就为1)    |    0011 | 1011 => 1011
 按位与(两位只要有一个为0就为0)    &    0011 & 1011 => 0011
 按位取反    ～    0011 => 1100
 按位异或(相同为0不同为1)    ^    0011 ^ 1011 => 1000
 65 initWithString、stringWithString、initWithFormat、stringWithFormat的区别
 65.1 initWithString和stringWithString
 65.1.1 NSString调用
 initWithString，stringWithString生成一个常量字符串，只读取数据
 使用[[NSString alloc]initWithString:]、[NSString stringWithString:]方式获取的是一个不可变的字符串常量，而这个常量是存放到内存中的常量区。不用引用计数管理内存，代码如下

 NSString *str1 = @"1";
 NSString *str2 = [[NSString alloc]initWithString:@"1"];
 NSString *str3 = [NSString stringWithString:@"1"];

 打印内容：
 str1:__NSCFConstantString,0x7ffee9bb3868,0x10604b060,1,retaincount = -1
 str2:__NSCFConstantString,0x7ffee9bb3860,0x10604b060,1,retaincount = -1
 str3:__NSCFConstantString,0x7ffee9bb3858,0x10604b060,1,retaincount = -1
 65.1.2 NSMutableString调用
 initWithString，stringWithString生成一个可变对象，会另外申请空间存放后面的常量字符串，这时其retaincount为1，代码如下：

 NSMutableString *str4 = [[NSMutableString alloc]initWithString:@"1"];
 NSMutableString *str5 = [NSMutableString stringWithString:@"1"];
 //打印
 str4:__NSCFString,0x7ffee67c3850,0x6000038dde90,1,retaincount = 1
 str5:__NSCFString,0x7ffee67c3848,0x6000038de1c0,1,retaincount = 1
 65.1.2 总结
 initWithString是实例方式，是字符串对象初始化的方法，而stringWithString这个则是一个工厂方法，并不是类的初始化构造方法
 两种方法，从结果来看没有区别
 对于可变生成一个全新的对象(开辟堆空间)，不可变对象创建的时候生成一个常量字符串，只读取数据
 65.2 initWithFormat和stringWithFormat
 65.2.1 NSString调用
 调用initWithFormat:、stringWithFormat是一编码格式读入数据，数据存放在哪是根据读入的参数确定的
 减少内存开销，减少不必要的堆空间开辟例如：
 NSInteger在32系统中是4个字节在64位占8个字节，如果一个变量的值为1，那么在8个字节中也就只占用了1位，有63位没有被使用，为了1位区开辟一块堆区域，很浪费，为了减少性能的消耗，而采取了变量指针来直接进行值操作。
 代码如下：

 //当字符串不超过字符串的内存空间，那么就使用NSTaggedPointerString
 NSString *str1 = @"sa";
 NSString *str2 = [[NSString alloc]initWithFormat:@"%@",str1];
 NSString *str3 = [NSString stringWithFormat:@"%@",str1];

 打印如下：
 str1:__NSCFConstantString,0x7ffee6628868,0x1095d6060,sa,retaincount = -1
 str2:NSTaggedPointerString,0x7ffee6628860,0xe5343da0d0e38890,sa,retaincount = -1
 str3:NSTaggedPointerString,0x7ffee6628858,0xe5343da0d0e38890,sa,retaincount = -1

 //当字符串超过字符串的内存空间，那么就使用NSTaggedPointerString
 NSString *str1 = @"sa321312312312";
 NSString *str2 = [[NSString alloc]initWithFormat:@"%@",str1];
 NSString *str3 = [NSString stringWithFormat:@"%@",str1];

 打印如下：
 str1:__NSCFConstantString,0x7ffee412d868,0x10bad1060,sa321312312312,retaincount = -1
 str2:__NSCFString,0x7ffee412d860,0x600000939060,sa321312312312,retaincount = 1
 str3:__NSCFString,0x7ffee412d858,0x600000939080,sa321312312312,retaincount = 1

 65.2.2 NSMutableString调用
 调用initWithFormat:、stringWithFormat不管输入的数据是什么都会开辟堆空间
 代码如下：

 NSMutableString *str4 = [[NSMutableString alloc]initWithFormat:@"%@",str1];
 NSMutableString *str5 = [NSMutableString stringWithFormat:@"%@",str1];

 打印如下：
 str4:__NSCFString,0x7ffeef95a850,0x6000024c93e0,sa3213123123121,retaincount = 1
 str5:__NSCFString,0x7ffeef95a848,0x6000024c96e0,sa3213123123121,retaincount = 1
 65.2.3 总结
 initWithFormat是构造初始化方法，而stringWithFormat是工厂类方法
 initWithFormat、stringWithFormat都是重新创建一个对象，重新开辟堆空间，不同点在于在不可变对象调用这两个方法的时候，如果这个对象的值的大小不超过你的指针占位大小，就是使用taggedpointer这个指针做值的特性，从而减小系统资源的浪费，
 65.3 总结
 在不可变字符串中：

 initWithFormat、stringWithFormat生成一个新的对象，可分为taggedpointer
 initWithString，stringWithString生成了一个常量
 在可变字符串中

 initWithFormat、stringWithFormat与initWithString，stringWithString生成一个新的对象
 initWithFormat、stringWithFormat
 66 Autorelease返回值的快速释放机制
 ARC下，runtime有一套对autorelease返回值的优化策略。
 比如在一个工厂方法中：

 + (instancetype)CreateObject {
     return [self new];
 }
 Sark *sark = [Sark createSark];
 谁创建谁释放的原则，返回值需要是一个autorelease对象才能配合调用方正确管理内存，于是乎编译器改写成了形如下面的代码：

 + (instancetype)createSark {
     id tmp = [self new];
     return objc_autoreleaseReturnValue(tmp); // 代替我们调用autorelease
 }
 // caller
 id tmp = objc_retainAutoreleasedReturnValue([Sark createSark]) // 代替我们调用retain
 Sark *sark = tmp;
 objc_storeStrong(&sark, nil); // 相当于代替我们调用了release
 Thread Local Storage(线程局部存储 TLS)通过

 Thread Local Storage（TLS）线程局部存储，目的很简单，将一块内存作为某个线程专有的存储，以key-value的形式进行读写，比如在非arm架构下，使用pthread提供的方法实现：

 void* pthread_getspecific(pthread_key_t);
 int pthread_setspecific(pthread_key_t , const void *);
 在返回值身上调用objc_autoreleaseReturnValue方法时，runtime将这个返回值object储存在TLS中，然后直接返回这个object（不调用autorelease）；同时，在外部接收这个返回值的objc_retainAutoreleasedReturnValue里，发现TLS中正好存了这个对象，那么直接返回这个object（不调用retain）。
 于是乎，调用方和被调方利用TLS做中转，很有默契的免去了对返回值的内存管理。

 67 block循环引用
 typedef void(^MyBlock)();
 @property (copy, nonatomic) MyBlock myBlock;
 @property (copy, nonatomic) NSString *blockString;

 - (void)testBlock {
     self.myBlock = ^() {
         NSLog(@"%@",self.blockString);//产生了循环引用
     };
 }
 上述代码：由于block会对block中的对象进行持有操作,就相当于持有了其中的对象，而如果此时block中的对象又持有了该block，则会造成循环引用。解决方案就是添加__weak

 __weak typeof(self) weakSelf = self;

 self.myBlock = ^() {
         NSLog(@"%@",weakSelf.blockString);//没有产生循环引用
  };
 并不是所有block都会造成循环引用,只有被强引用了的block才会产生循环引用,比如dispatch_async(dispatch_get_main_queue(), ^{}),[UIView animateWithDuration:1 animations:^{}]这些系统方法等或者block不是强引用而是临时变量，简单来说栈block不会产生循环引用。

 typedef void(^MyBlock)(void);
 - (void)testWithBlock:(MyBlock)block {
     block();
 }
 [self testWithBlock:^{
     NSLog(@"%@",self);//不会产生循环引用
 }];
     
 还有一种情况：在一个实例类A中强引用了一个block和一个实例B，这个block执行过程中调用了实例B中的属性，且在执行过程中实例B释放了，此时访问实例B是没有任何反应的。

 typedef void(^MyBlock)();
 @property (copy, nonatomic) MyBlock myBlock;
 @property (copy, nonatomic) NSString *blockString;
 @property (strong,nonatomic)UserModel *user;
 self.user = [[UserModel alloc]init];
 self.user.nama = @"wode";
     
 __weak typeof(self.user)weakuser = self.user;
     
 self.myBlock = ^{
     //self.user 再别的地方玩释放了它,所以应该保持住它
     __strong typeof(weakuser)stronguser = weakuser;
     
     NSLog(@"%@",stronguser.nama);
 };
     self.myBlock();

 68 NSTimer循环引用属于相互循环使用
 在对象实例中，创建一个NSTimer做为一个属性，由于定时器创建后会请引用这个实例对戏那个，该实例对象和NSTimer互相引用，形成循环引用。
 解决方式：

 如果是不重复的定时器，可以在回调中直接invalidate并置为nil即可
 如果是重复定时器，需要你在这个定向销毁之前调用invalidate并置为nil即可
 69 代理(delegate)循环引用属于相互循环引用
 delegate 是iOS中开发中比较常遇到的循环引用，一般在声明delegate的时候都要使用弱引用 weak,或者assign,当然怎么选择使用assign还是weak，MRC的话只能用assign，在ARC的情况下最好使用weak，因为weak修饰的变量在释放后自动指向nil，防止野指针存在

 70 __block的作用
 还可以使用__block来修饰变量
 在MRC下，__block不会增加其引用计数，避免了循环引用
 在ARC下，__block修饰对象会被强引用，无法避免循环引用，需要手动解除。

 71 UITableViewCell如何优化
 简单优化：

 正确的处理Cell的复用
 尽量少或不设置cell及子类的透明度
 cell中内容设计到延迟内容的代码，尽量使用异步操作，主线程通知结果或刷新UI
 尽量少的在heightForRowAtIndexPath:中去增加一些计算量操作，可以直接在请求结果以后在直接计算出高度在通知UI刷新
 尽可能的在cell中addView，尽量减少subviews
 进一步优化

 滑动过程中按需要加在数据(与SDWebImage异步加载会更好)
 避免大量的图片缩放，最好是大小刚刚好的资源，如果必须缩放也必须是图片等比缩放
 避免使用CALayer特效
 高级优化

 异步绘制界面，主线程刷新UI
 缓存所有计算、以及负责的创建类、耗费系统资源的对象，使用时直接赋值。
 72 什么是image
 Executable：应用的主要二进制(比如.0文件) 可执行文件
 Dylib:动态链接库
 Bundle: 资源文件
 73 App启动性能优化
 73.1 (Main函数加载之前的调用优化)Total pre-main time
 在Xcode->Edit scheme->Arguments->Environment Variables中添加key = DYLD_PRINT_STATISTICS，value = YES，就可以打印出来pre-main的内容

 Total pre-main time: 910.97 milliseconds (100.0%)
          dylib loading time: 126.46 milliseconds (13.8%)
         rebase/binding time: 697.11 milliseconds (76.5%)
             ObjC setup time:  59.21 milliseconds (6.5%)
            initializer time:  28.00 milliseconds (3.0%)
            slowest intializers :
              libSystem.B.dylib :   3.04 milliseconds (0.3%)
 从上面可以看到过程

 dylib loading time 动态库加载过程花费的时间
 rebase bind time 重定绑定，
 因为iOS引入了ASLR技术和代码签名
 镜像会在随机的地址上进行加载，和之前指针指向的地址会有一个偏差，dyld需要修正这个偏差
 Objc setup time 对象设置时间
 注册声明过的Objc类
 将分类插入类的方法列表
 检查selector的唯一性
 initializer time 初始化器时间
 调用每个Objc类和分类的+load方法
 调用C/C++中的构造器函数
 创建非基本类型全局变量
 73.1.1 dylib loading加载优化
 尽量合并已有的动态库和静态库，减少这些库的个数
 73.1.2 rebase bind 优化
 减少Objc类、方法、分类的数量
 减少C++虚函数的数量
 在Swift中尽量多使用Struct因为这个事值类型不是对象
 更多的使用值类型
 73.1.3 Objc setup 优化
 如果rebase bind已经做的很好，那么Objc setup 也就完成了
 73.1.4 Initializers
 少在类的+load方法里做事情，尽量把这些事情推迟到+initiailize
 减少构造器函数个数，在构造器函数里少做些事情
 减少C++静态全局变量的个数
 73.2 (Main调用之后优化)main After
 满足业务需要的前提下，didFinishLaunchingWithOptions在主线程里做的事情越少越好:

 梳理三方库，将可以延迟加载的库，推迟处理
 梳理业务逻辑，可以延迟执行的，推迟执行
 避免多余的逻辑计算
 尽量不要在首屏界面viewWillAppear，以及viewDidLoad中做太多的事情，可以延迟创建的对象可以使用懒加载
 首屏建议使用纯代码开发，速度比较快
 持久化读取数据到内存中是不是需要时间，这个操作是否可以延迟处理
 使用instruments的time profiler分析
 74 swift和oc的区别
 74.1 Protocol不同：
     OC：    主要用来传值，传递事件
     Swift： 不仅仅可以传值跟传递事件，
             可以在协议中定义属性以及方法，
             并且还能对其进行扩展，
 74.2 类型推断
     OC：    在定义属性的多时候必须添加你的类型(id是一个指向所有类的指针)
     swift： 当我添加一个变量的时候，我无需定义他的类型，会根据初始化的值，推断出来适合这个值的一个类型
 74.3 结构体和类
     OC：    结构体值类型、类指针类型，
             简单谈一下结构体，因为这个是跟swift的最大的差别：
                 1. 通常情况下，我们在初始化结构体完成以后如果需要修改结构体中的成员变量，直接使用点语法就能直接修改成员变量，
                 2. 当一个对象持有一个结构体变量，如果不使用属性property，默认是受保护的，所以你并不能修改这个结构体
                 3. 当一个对象中有一个结构体属性的时候，点语法其实就是setter、getter方法，当我获取这个属性的时候，如果是类对象，那么就是这个属性的引用，如果是结构体getter返回的值就是一个新的结构体的值，你在怎么修改也不会影响到这个对象中的结构体属性。
                 
                 
     swift： 结构体值类型、类指针类型，这个规则并没有改变
             对比OC，Swift中的结构体的功能被扩大了，基本上拥有了类差不多的功能
                 1.定义属性
                 2.定义方法
                 3.定义getter和setter
                 4.可以定义初始化器来设置初始状态
                 5.实现扩展的功能
                 6.遵守协议，并实现协议的方法
                 7.结构总是被复制，并不使用引用计数
             不过也有一些结构体不具备的类的功能
                 1.允许一个类继承另一个类的特征
                 2.能够在运行时检查和解释类实例的类型
                 3.初始化器使一个类的实例能够释放它所分配的任何资源，可以使用deinit来释放资源
                 4.引用计数允许多个引用到一个类实例
             总体来讲struct的优势在于：
                     1.结构较小，适用于复制操作，相比一个class的实例被多次引用，struct更加安全
                     2.更不需要担心内存泄漏以及多线程冲突问题
             可以定义inout的关键字来让值类型可以进行引用传递
             swift之所以讲Dictionary、array、String设计成值类型：
                     1.值类型在栈上面操作，而引用类型在堆上面操作，栈上的操作仅仅是单个指针的移动，而堆上面的操作牵扯到合并、移动、重新链接等问题，这样做大幅度减少了堆上内存分配和回收的次数，从而讲开销降到最低。
                     2.解决并发，多线程、、循环引用、内存泄漏
 74.4 函数式编程
     OC只是面向对象的编程，而Swift既面向对象又是面向函数式的编程
     特点：
             1. 没有附加作用， 函数保持独立，所有功能就是返回一个值，没有其他行为，尤其是不得修改外部的变量
             2. 不修改状态，也不会修改系统的变量，后者函数内部对象的变量，只是单纯的算法
             3.  引用透明，函数运行不依赖于外部变量和状态，只依赖于传递的参数。任何情况下，只要传递的参数相同，那么得到的返回值都是一样的。
             4. 函数式编程可以看作成表达式，而并不是执行语句，表达式是一个单独的计算公式，总是有一个返回值，而执行语句，只是执行过程并没有返回值。
     举例子说明：
     Swift中拥有 map，reduce、filter、flatmap这类数学函数式的方法，而OC并没有
 74.5 可选类型
     1.在oc中可选类型是为了表达一个变量的值是否为空的情况，如果为空，那么它就是nil，在Swift中这一概念被扩大化了，无论是引用变量还是值类型，都可以是可选类型。
     2.在Swift当中明确提出可选类型的概念，当我的变量(不管是值还是引用类型)，可以是空值，我就在变量类型的后面加上?如果这个变量类型后面没有加任何修饰符号，或者加了!那么这个值是必须有一个值的，
 74.6 属性观察以及setter、getter
     1.在OC中，属性观察需要KVO，Setter、getter方法可以是有property、或者自定义setter、getter方法
     2.而在swift中，属性观察增加一个初始化时就可以直接观察的方式，willset、以及didSet
 74.7 swift有一个copy-on-write功能
 当数组A copy生成数组B，两个数组是同样的地址，当我修改数组B中的元素的，在打印会发现，数组B完全变成了另外一个数组，而数组A不变，这就是copy-on-write
 75 SDWebImage怎么实现的
 75.1 角色划分
 UIimageView+WebCache 提供给客户端的一个API
 SDWebImageManager 这个是管理中心
 SDWebImageDownLoader 这个是下载中心 有operationQueue
 SDWebImageDownLoaderOperation 抽象的网络操作
 SDImageCache
 SDImageCachesManager 图片缓存类 主要做缓存操作
 SDImageCachesManagerOperation 单独的缓存类
 SDDiskCache 磁盘缓存类
 SDWebImagePrefetcher 批量缓存器‘
 SDWebImageDecoder 解码器 Argb专程rgb
 SDWebImageCompat 平台兼容性类
 75.1 优点：
 提供很多分类，这些分类都可以使用图片缓存 如：ImageView、UIbutton、MKAnnotationView、UIview
 异步下载图片
 异步缓存、内存+磁盘缓存
 后台解压缩
 同一个URL不会重复下载
 自动是被无效的URL，不重复系在
 不阻塞主线程
 高性能
 使用GCD和ARC结合
 支持多种图片格式
 支持动态图片
 75.1 缓存过程
 UIimageView->管理器->下载器->缓存器
 2.3版本

 Client通过UIimageView类扩展调用sd_setImageWithURL方法通知Manager
 Manager通过downloadWithURL方法告诉SDImageCache中的queryDiskCacheForKey方法来检查磁盘是否缓存
 SDImageCache的方法中会首先检测内存是否缓存，再去磁盘读取(使用了队列NSOperationQueue * cacheOutQueue)，是否有缓存，如果没有缓存那么就会通知给SDWebImageDownloader下载图片
 SDWebImageDownloader下载完成通知更新UI，并通知SDImageCache缓存图片
 有队列类型 先进先出 先进后出
 设置请求头
 SDImageCache 先缓存内存，在缓存磁盘 缓存磁盘的时候用了队列的形式NSOperationQueue * cacheInQueue
 75.2 URL不变怎么知道图片更新
 NSURLRequestUseProtocolCachePolicy:对特定的URL请求使用网络协议（如HTTP）中实现的缓存逻辑。这是默认的策略。该策略表示如果缓存不存在，直接从服务端获取。如果缓存存在，会根据response中的Cache-Control字段判断 下一步操作，如: Cache-Control字段为must-revalidata, 则 询问服务端该数据是否有更新，无更新话 直接返回给用户缓存数据，若已更新，则请求服务端

 75.3 为啥要解码
 图片格式转换， jpg->png，gif->jpg，iOS不支持透明通道 不支持arpg

 75.4 设计模式
 下载重载，如果当我去下载图片的时候，将这下载对象缓存在内存当中，如果这个图片没有下载成功是不会清理的。

 75.5 为什么添加图片类型
 为了区分 gif跟普通图片
 因为根据规则，图片数据的第一个字节是图片的类型，

 76 子视图随父视图动画
 76.1 设置clipsToBounds
 YES剪裁超出父视图范围的子视图部分。当设置成NO的时候，不剪裁超出父视图范围的子视图，

 设置YES以后这样视觉上来说是子视图在跟随父视图变化，但其实是被裁减了
 77 项目开发中业务分层
 四层：

 网络层 Networklayer
 业务层 Business
 数据层 Data
 工具层 Utils
 项目结构
 网路基础库结构
 网络层和业务层
 业务层分层结构
 UI展示层结构
 UI展示层和业务层

 78 项目开发->存在的疑惑
 层与层之间的关系？
 (网路基础层)和(业务层分层)怎么交互需要通过(网络层和业务层)
 (业务层分层)和(UI展示层)如何交互需要通过(UI展示层和业务层)
 主程序如何引用静态库的？
 引用4个组件：
 1.导入静态库到项目中，(出现错误需要关闭静态库项目，重新打开就好)
 2.项目配置setting target dependencies 添加静态库
 3.配置我们头文件 user header User Header search Paths 添加静态库的路径
 第三方库的引用链接：哪些需要哪些不需要
 1.主程序依赖:UI层
 2.UI层之外的不需要
 静态库引用静态库？
 静态库配置setting 搜索search paths User Header search Paths 添加静态库的路径
 静态库如何引用pods第三方库？
 安装一个pods 添加pod库，搜索search paths User Header search Paths 添加pod中header中的路径
 各层之间为什么要通过组建化的方式来设计？
 为什么要使用静态库来做？
 79 新建的静态库在哪存放？
 静态库全部在根目录单独的文件夹

 80 C与OC的桥接(Core Foundation和Foundation的桥接)
 __bridge只做类型转换，但是不修改对象（内存）管理权；
 __bridge_retained（也可以使用CFBridgingRetain）将Objective-C的对象转换为Core Foundation的对象，同时将对象（内存）的管理权交给我们，后续需要使用CFRelease或者相关方法来释放对象；
 __bridge_transfer（也可以使用CFBridgingRelease）将Core Foundation的对象转换为Objective-C的对象，同时将对象（内存）的管理权交给ARC。
 
 
 
 
 
 在WWDC 2016上首次提到了关于App应用启动速度优化的话题:Session 406 Optimizing App Startup Time .该Session上Apple建议一个App完整的启动时间应该保证400ms之内,而若超过20s后还未完全启动App,那么App进程就会被系统杀死.而如何Debug和优化应用启动的时间,官方提出一系列方法来关注应用启动时执行main()前究竟干了些什么.而通过这个Session,你会了解到以下内容:

 如何获得应用加载的时间
 执行程序入门的代码前App加载过程中的流程
 如何优化App的加载时间
 测量Pre-main Time
 一个App在执行main函数前包括app delegate的系列方法如applicationWillFinishLaunching时,会做许多系统级别的准备.而在iOS10之前,开发者很难清楚自己App为何启动加载慢.而通过在工程的scheme中添加环境变量DYLD_PRINT_STATISTICS,设置Value为1,App启动加载时就会有启动过程的日志输出. 现在(iOS 10之后)Apple对DYLD_PRINT_STATISTICS的日志输出结果进行了简化,使得更容易让开发者理解.

 指定Scheme上添加DYLD_PRINT_STATISTICS环境变量
 尝试在iPad (使用iOS10 beta 3)上对一个纯OC项目设置该环境变量后,有了以下输出信息.

 Total pre-main time:  74.37 milliseconds (100.0%)
        dylib loading time:  41.05 milliseconds (55.2%)
       rebase/binding time:   8.10 milliseconds (10.9%)
           ObjC setup time:   9.87 milliseconds (13.2%)
          initializer time:  15.23 milliseconds (20.4%)
          slowest intializers :
            libSystem.B.dylib :   6.58 milliseconds (8.8%)
  libBacktraceRecording.dylib :   6.27 milliseconds (8.4%)
 输出内容展示了系统调用main()函前主要进行的工作内容和时间花费,Session上也对每一阶段加载过程具体内容进行了详细的叙述,有兴趣地可观看该Session.

 启动优化
 那么如何尽可能的减少pre-main花费的时间呢,主要就从输出日志给出的四个阶段下手:

 对动态库加载的时间优化.每个App都进行动态库加载,其中系统级别的动态库占据了绝大数,而针对系统级别的动态库都是经过系统高度优化的,不用担心时间的花费.开发者应该关注于自己集成到App的那些动态库,这也是最能消耗加载时间的地方.对此Apple建议减少在App里开发者的动态库集成或者有可能地将其多个动态库最终集成一个动态库后进行导入, 尽量保证将App现有的非系统级的动态库个数保证在6个以内.

 减少Appp的Objective-C类,分类和的唯一Selector的个数.这样做主要是为了加快程序的整个动态链接, 在进行动态库的重定位和绑定(Rebase/binding)过程中减少指针修正的使用,加快程序机器码的生成.

 减少Objc运行初始化的时间花费.主要是类的注册,分类的注册,唯一选择器的存在,以及涉及子父类内存布局的Non Fragile ivars偏移的更新,都会影响Objective-C运行时初始化的时间消耗.

 使用initialize方法进行必要的初始化工作.用+initialize方法替换调用原先在OC的+load方法中执行初始代码工作,从而加快所有类文件的加载速度.

 结尾
 最后演讲者对加载启动优化的整体概括了Session所要传达的内容:

 使用DYLD_PRINT_STATISTICS测试启动加载时间
 减少自定义的动态库集成
 精简原有的Objective-C类和代码
 移除静态的初始化操作
 使用更多的Swift代码

 
 
 
 
 

 */
