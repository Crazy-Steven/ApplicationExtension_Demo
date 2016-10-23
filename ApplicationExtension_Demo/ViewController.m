//
//  ViewController.m
//  ApplicationExtension_Demo
//
//  Created by 郭艾超 on 16/10/11.
//  Copyright © 2016年 Steven. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *myTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didEndAndExit:(id)sender {
    [self saveBtnAction:nil];
}

- (IBAction)saveBtnAction:(id)sender {
    
    NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.steven.app"];
    [userDefaults setObject:_myTextField.text forKey:@"shareData"];
    [userDefaults synchronize];
}

@end
