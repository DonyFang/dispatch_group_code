//
//  ViewController.m
//  dispatch_group
//
//  Created by 方冬冬 on 2017/7/13.
//  Copyright © 2017年 方冬冬. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    

}

//第二种：异步任务时
- (void)queueConcurrentMethodSecond{
    
    dispatch_queue_t queue1 = dispatch_queue_create("dispatchGroupMethod1.queue1", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t group1 = dispatch_group_create();
    
    dispatch_group_async(group1, queue1, ^{
        dispatch_async(queue1, ^{
            for (NSInteger i =0; i<3; i++) {
                sleep(1);
                NSLog(@"%@-异步任务执行-:%ld",@"任务1",(long)i);
                
            }
        });
    });
    
    
    dispatch_group_async(group1, queue1, ^{
        dispatch_async(queue1, ^{
            for (NSInteger i =0; i<3; i++) {
                sleep(1);
                NSLog(@"%@-异步任务执行-:%ld",@"任务2",(long)i);
                
            }
        });
    });
    
    //    //等待上面的任务全部完成后，会往下继续执行 （会阻塞当前线程）
    //    dispatch_group_wait(group1, DISPATCH_TIME_FOREVER);
    
    //等待上面的任务全部完成后，会收到通知执行block中的代码 （不会阻塞线程）
    dispatch_group_notify(group1, queue1, ^{
        NSLog(@"Method1-全部任务执行完成");
    });

}


//同步任务
- (void)queueConcurrentMethod{

    
    dispatch_queue_t queue1 = dispatch_queue_create("dispatchGroupMethod1.queue1", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t group1 = dispatch_group_create();
    
    dispatch_group_async(group1, queue1, ^{
        dispatch_sync(queue1, ^{
            for (NSInteger i =0; i<3; i++) {
                sleep(1);
                NSLog(@"%@-同步任务执行-:%ld",@"任务1",(long)i);
                
            }
        });
    });
    
    
    dispatch_group_async(group1, queue1, ^{
        dispatch_sync(queue1, ^{
            for (NSInteger i =0; i<3; i++) {
                sleep(1);
                NSLog(@"%@-同步任务执行-:%ld",@"任务2",(long)i);
                
            }
        });
    });
    
    //    //等待上面的任务全部完成后，会往下继续执行 （会阻塞当前线程）
    //    dispatch_group_wait(group1, DISPATCH_TIME_FOREVER);
    
    //等待上面的任务全部完成后，会收到通知执行block中的代码 （不会阻塞线程）
    dispatch_group_notify(group1, queue1, ^{
        NSLog(@"Method1-全部任务执行完成");
    });


}

//同步任务
- (void)queueConcurrentMethodThird{
//    复制代码
    dispatch_queue_t queue2 = dispatch_queue_create("dispatchGroupMethod2.queue2", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t group2 = dispatch_group_create();
    
    
    dispatch_group_enter(group2);
    dispatch_sync(queue2, ^{
        for (NSInteger i =0; i<3; i++) {
            sleep(1);
            NSLog(@"%@-同步任务执行-:%ld",@"任务1",(long)i);
            
        }
        dispatch_group_leave(group2);
    });
    
    
    
    dispatch_group_enter(group2);
    dispatch_sync(queue2, ^{
        for (NSInteger i =0; i<3; i++) {
            sleep(1);
            NSLog(@"%@-同步任务执行-:%ld",@"任务2",(long)i);
            
        }
        dispatch_group_leave(group2);
    });
    
    //    //等待上面的任务全部完成后，会往下继续执行 （会阻塞当前线程）
    //    dispatch_group_wait(group2, DISPATCH_TIME_FOREVER);
    
    //等待上面的任务全部完成后，会收到通知执行block中的代码 （不会阻塞线程）
    dispatch_group_notify(group2, queue2, ^{
        NSLog(@"Method2-全部任务执行完成");
    });
    


}


//异步任务
- (void)queueConcurrentMethodFour{

    dispatch_queue_t queue2 = dispatch_queue_create("dispatchGroupMethod2.queue2", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t group2 = dispatch_group_create();
    
//    声明dispatch_group_enter(group)下面的任务由group组管理，group组的任务数+1
    dispatch_group_enter(group2);
    dispatch_async(queue2, ^{
        for (NSInteger i =0; i<3; i++) {
            sleep(1);
            NSLog(@"%@-异步任务执行-:%ld",@"任务1",(long)i);
            
        }
//        相应的任务执行完成，group组的任务数-1

        dispatch_group_leave(group2);
    });
    
    
    
    dispatch_group_enter(group2);
    dispatch_async(queue2, ^{
        for (NSInteger i =0; i<3; i++) {
            sleep(1);
            NSLog(@"%@-异步任务执行-:%ld",@"任务2",(long)i);
            
        }
        dispatch_group_leave(group2);
    });
    
    //    //等待上面的任务全部完成后，会往下继续执行 （会阻塞当前线程）
    //    dispatch_group_wait(group2, DISPATCH_TIME_FOREVER);
    
    //等待上面的任务全部完成后，会收到通知执行block中的代码 （不会阻塞线程）「监听group组中任务的完成状态，当所有的任务都执行完成后，触发block块，执行总结性处理。
    
    dispatch_group_notify(group2, queue2, ^{
        NSLog(@"Method2-全部任务执行完成");
    });

}


@end
