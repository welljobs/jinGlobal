//
//  EnvironmentOperation.m
//  jinGlobal
//
//  Created by 1GE on 16/6/27.
//  Copyright © 2016年 1GE. All rights reserved.
//

#import "EnvironmentOperation.h"

@implementation EnvironmentOperation
- (id)initWithUrl:(NSString *)url delegate:(id<DownloadOperationDelegate>)delegate {
    if (self = [super init]) {
        self.imageUrl = url;
        self.delegate = delegate;
    }
    return self;
}
//重写“main”方法,实现main方法, 线程串行执行; 实现start方法, 线程并发执行.
- (void)main {
    // 新建一个自动释放池，如果是异步执行操作，那么将无法访问到主线程的自动释放池
    @autoreleasepool {
        //将自己的代码放在autoreleasepool中
        if (self.isCancelled) return;
        
        // 获取图片数据
        NSURL *url = [NSURL URLWithString:self.imageUrl];
        NSData *imageData = [NSData dataWithContentsOfURL:url];
        
        if (self.isCancelled) {
            url = nil;
            imageData = nil;
            return;
        }
        
        // 初始化图片
        UIImage *image = [UIImage imageWithData:imageData];
        
        if (self.isCancelled) {
            image = nil;
            return;
        }
        
        if ([self.delegate respondsToSelector:@selector(downloadFinishWithImage:)]) {
            // 把图片数据传回到主线程
            [(NSObject *)self.delegate performSelectorOnMainThread:@selector(downloadFinishWithImage:) withObject:image waitUntilDone:NO];
        }
    }
}
//- (void)main{
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
//    dispatch_time_t when = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3*NSEC_PER_SEC));
//    dispatch_after(when, queue, ^{
//        [self printHello];
//    });
//}
//- (void)printHello{
//    NSLog(@"---Hello World!");
//}
//- (void)start
//{
//    if ([self isCancelled]) {
//        _efinished = YES;
//        return;
//    } else {
//        _eexecuting = YES;
//        //start your task;
//        
//        //end your task
//        
//        _eexecuting = NO;
//        _efinished = YES;
//    }
//}
//- (void)setFinished:(BOOL)finished {
//    [self willChangeValueForKey:@"isFinished"];
//    _efinished = finished;
//    [self didChangeValueForKey:@"isFinished"];
//}
//
//- (void)setExecuting:(BOOL)executing {
//    [self willChangeValueForKey:@"isExecuting"];
//    _eexecuting = executing;
//    [self didChangeValueForKey:@"isExecuting"];
//}
@end
