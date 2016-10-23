//
//  ViewController1.m
//  ApplicationExtension_Demo
//
//  Created by 郭艾超 on 16/10/24.
//  Copyright © 2016年 Steven. All rights reserved.
//

#import "ViewController1.h"

@interface ViewController1 ()
@property (strong, nonatomic) IBOutlet UIView *myView;
@property (weak, nonatomic) IBOutlet UIImageView *myImageView;
@property (weak, nonatomic) IBOutlet UILabel *shareLabel;
@property (weak, nonatomic) IBOutlet UILabel *urlLabel;

@end

@implementation ViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
        // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.steven.app"];
    NSLog(@"----%d",[userDefaults boolForKey:@"isShare"]);
    if ([userDefaults boolForKey:@"isShare"]) {
        _myView.hidden = NO;
        _myImageView.image = [UIImage imageWithData:[userDefaults objectForKey:@"shareImage"]];
        _shareLabel.text = [userDefaults objectForKey:@"shareText"];
        _urlLabel.text = [userDefaults objectForKey:@"shareURL"];
    }else {
        _myView.hidden = YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
