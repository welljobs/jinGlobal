//
//  EnvironmentOperation.h
//  jinGlobal
//
//  Created by 1GE on 16/6/27.
//  Copyright © 2016年 1GE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/*
 1、NSOperation的使用方法
 【1】、继承NSOperation类
 【2】、重写“main”方法
 【3】、在“main”方法中创建一个autoreleasepool
 【4】、将自己的代码放在autoreleasepool中
 注意：创建自动释放池的原因是，你不能访问主线程的自动释放池，所以需要自己创建一个。
 
 
 2、NSOperation的常用方法
 【1】、start：开始方法，当把NSOperation添加到NSOperationQueue中去后，队列会在操作中调用start方法。
 【2】、addDependency，removeDependency：添加从属性，删除从属性，比如说有线程a，b，如果操作a从属于b，那么a会等到b结束后才开始执行。
 【3】、setQueuePriority：设置线程的优先级。例：[a setQueuePriority:NSOperationQueuePriorityVeryLow];一共有四个优先级：NSOperationQueuePriorityLow，NSOperationQueuePriorityNormal，NSOperationQueuePriorityHigh，NSOperationQueuePriorityVeryHigh。
 当你添加一个操作到一个队列时，在对操作调用start之前，NSOperationQueue会浏览所有的操作，具有较高优先级的操作会优先执行，具有相同优先级的操作会按照添加到队列中顺序执行。
 【4】、setCompletionBlock：设置回调方法，当操作结束后，会调用设置的回调block。这个block会在主线程中执行。
 

*/
@protocol DownloadOperationDelegate <NSObject>

- (void)downloadFinishWithImage:(UIImage *)image;

@end
@interface EnvironmentOperation : NSOperation

@property (nonatomic, assign) BOOL efinished;
@property (nonatomic, assign) BOOL eexecuting;
@property (nonatomic, copy) NSString *imageUrl;

@property (nonatomic, weak) id <DownloadOperationDelegate> delegate;

- (id)initWithUrl:(NSString *)url delegate:(id<DownloadOperationDelegate>)delegate;

@end
