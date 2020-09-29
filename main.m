//
//  main.m
//  main
//
//  Created by i on 2020/9/27.
//  Copyright © 2020 xlsn0w. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <malloc/malloc.h>

//int main(int argc, const char * argv[]) {
//    @autoreleasepool {
//        // insert code here...
//        NSLog(@"Hello, World!");
//    }
//    return 0;
//}


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSObject *obj = [[NSObject alloc] init];
        
        
        NSLog(@"lbobjc对象实际需要的内存大小: %zd", class_getInstanceSize([obj class]));
                
        NSLog(@"lbobjc对象实际分配的内存大小: %zd", malloc_size((__bridge const void *)(obj)));

    }
    return 0;
}

