//
//  ViewController.m
//  iOS_Tips_4
//
//  Created by yuanshi on 2020/7/17.
//  Copyright © 2020 yuanshi. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
        NSLog(@"%d", [self isMainQueue]);
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            
            NSLog(@"%d", [self isMainQueue]);
        });
    
    // iOS isDescendantOfView
    
    
    [self.view addSubview:self.textView];
    BOOL isDescendant =  [self.textView isDescendantOfView:self.view];
    if (isDescendant) {
        
        NSLog(@"Yes,self.textView isDescendantOfView:self.view");
    }
    
    
    // ASCII 和 NSString 相互转换
    // NSString to ASCII
    NSString *string = @"B";
    int asciiCode = [string characterAtIndex:0]; //66
        
    //ASCII to NSString
    int asciiCode1 = 66;
    NSString *string1 =[NSString stringWithFormat:@"%c",asciiCode]; //B
   
}
// 主线程判断
- (BOOL)isMainQueue {

    return strcmp(dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL), dispatch_queue_get_label(dispatch_get_main_queue())) == 0;
}
// UITextFiled 不可以被粘贴
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        
        if (@available(iOS 13.0, *)) {
            
            [[UIMenuController sharedMenuController] showMenuFromView:nil rect:CGRectZero];
        } else {
            
            [[UIMenuController sharedMenuController] setMenuVisible:NO animated:NO];
        }
    }];
    
    return [super canPerformAction:action withSender:sender];
}

// iOS字符串去掉中间空格、首尾两端空白、换行符、回车符
- (NSString *)noWhitespaceString:(NSString *)string {
    
   string = [[[[[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]
                stringByReplacingOccurrencesOfString:@"/r" withString:@""]
                stringByReplacingOccurrencesOfString:@"/n" withString:@""]
                stringByReplacingOccurrencesOfString:@" " withString:@""]
                stringByReplacingOccurrencesOfString:@"/tab" withString:@""];
   
   return string;
}

// iOS判断字符串中是否含有中文

- (BOOL)isChineseText:(NSString *)text {
    
    NSString *match = @"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:text];
}

// iOS应用直接退出

- (void)test:(id)sender {
    
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIWindow *window = app.window;
    [UIView animateWithDuration:1.0f animations:^{
        
        window.alpha = 0;
    } completion:^(BOOL finished) {
        
        exit(0);
    }];
}

- (void)setUserDefaultObjectValue:(id)obj WithKey:(NSString *)key {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:obj forKey:key];
    
    //BUG FIX:防止当应用突然退出时，数据没有保存
    [defaults synchronize];
}

- (id)userDefaultObjectValueWithKey:(NSString *)key {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:key];
}
@end
