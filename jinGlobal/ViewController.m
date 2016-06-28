//
//  ViewController.m
//  jinGlobal
//
//  Created by 1GE on 16/6/26.
//  Copyright © 2016年 1GE. All rights reserved.
//

#import "ViewController.h"
#import "BalencePoint.h"
#import "EnvironmentOperation.h"

typedef void (^IndexBlock)(size_t index);
static NSString  *url = @"http://api.erp.todoo.im/image/16/da/16da4e045e352efcde9c634dde526e55_image.jpg";
@interface ViewController ()<DownloadOperationDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController
-(void)downloadImage:(NSString *)url{
    NSLog(@"url:%@", url);
    NSURL *nsUrl = [NSURL URLWithString:url];
    NSError *error = nil;
    NSData *data = [NSData dataWithContentsOfURL:nsUrl options:NSDataReadingMappedIfSafe error:&error];
    if (error !=nil ) {
        NSLog(@"%@ === %ld", error,(long)[error code]);
    }
    UIImage * image = [[UIImage alloc]initWithData:data];
    
    [self performSelectorOnMainThread:@selector(updateUI:) withObject:image waitUntilDone:YES];
}
-(void)updateUI:(UIImage*) image{
    NSLog(@"image -== %@",image);
    self.imageView.image = image;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //使用系统NSOperation 子类NSInvocationOperation下载图片
//    NSInvocationOperation *operation=[[NSInvocationOperation alloc]initWithTarget:self selector:@selector(downloadImage:) object:url];
//    
//    [operation start];
    //自定义NSOperation 重载main方法下载图片
    EnvironmentOperation *opt = [[EnvironmentOperation alloc] initWithUrl:url delegate:self];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:opt];
    [opt main];
    
    NSLog(@"Main thread is here");
    
    BalencePoint *point = [[BalencePoint alloc] init];
    [point getBalencePoint:@[@(-7),@(1),@(5),@(2),@(-4),@(3),@(0)]];
    
    [point balences:@[@(-7),@(1),@(5),@(2),@(-4),@(3),@(0)]];
    
//    IndexBlock block = ^(size_t index){
//        static NSInteger count = 0;
//        NSLog(@"count == %@",@(count++));
//    };
//    dispatch_apply(5, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), block);
    
//    [self concurrentQueue];
}
- (void)downloadFinishWithImage:(UIImage *)image{
    self.imageView.image = image;
}
- (void)fileManagerQueue{
    NSArray *array = [NSArray arrayWithObjects:@"/Users/chentao/Desktop/copy_res/gelato.ds",
                      @"/Users/chentao/Desktop/copy_res/jason.ds",
                      @"/Users/chentao/Desktop/copy_res/jikejunyi.ds",
                      @"/Users/chentao/Desktop/copy_res/molly.ds",
                      @"/Users/chentao/Desktop/copy_res/zhangdachuan.ds",
                      nil];
    NSString *copyDes = @"/Users/chentao/Desktop/copy_des";
    NSFileManager *fileManager = [NSFileManager defaultManager];
    dispatch_async(dispatch_get_global_queue(0, 0), ^(){
        dispatch_apply([array count], dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^(size_t index){
            NSLog(@"copy-%ld", index);
            NSString *sourcePath = [array objectAtIndex:index];
            NSString *desPath = [NSString stringWithFormat:@"%@/%@", copyDes, [sourcePath lastPathComponent]];
            NSError* error=nil;
            [fileManager copyItemAtPath:sourcePath toPath:desPath error:&error ];
            if (error !=nil ) {
                NSLog(@"%@", [error userInfo]);
            }
        });
        NSLog(@"fileManager == %@",fileManager);
    });

}
- (void)concurrentQueue{
    NSMutableArray *array = [NSMutableArray array];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    //在Global Dispatch Queue中非同步执行
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        //dispathc_apply 是dispatch_sync 和dispatch_group的关联API.它以指定的次数将指定的Block加入到指定的队列中。并等待队列中操作全部完成.
        dispatch_apply(100, queue, ^(size_t idx) {
            //这个地方不明白往数组插图数据崩了.
            //这个block 是在 ［array insertObject：atIndex:］调用之后返回的
            [array insertObject:@(idx) atIndex:0];
        });
        NSLog(@"------%@",@(array.count));
    });
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
