//
//  TodayViewController.m
//  Today_Extension
//
//  Created by 郭艾超 on 16/10/11.
//  Copyright © 2016年 Steven. All rights reserved.
//

#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"%s:%d\t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(...)
#endif

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
#import "TableViewCell.h"

@interface TodayViewController () <NCWidgetProviding,UITableViewDelegate,UITableViewDataSource>
@property (assign, nonatomic)NSInteger rowCount;
@property (assign, nonatomic)CGSize defaultSize;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@end

@implementation TodayViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    _defaultSize = [self.extensionContext widgetMaximumSizeForDisplayMode:NCWidgetDisplayModeCompact];
    
    self.extensionContext.widgetLargestAvailableDisplayMode = NCWidgetDisplayModeExpanded;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)widgetActiveDisplayModeDidChange:(NCWidgetDisplayMode)activeDisplayMode withMaximumSize:(CGSize)maxSize
{
    if (activeDisplayMode == NCWidgetDisplayModeCompact) {
        self.preferredContentSize = _defaultSize;

        NSLog(@"size1:%@",NSStringFromCGSize(self.preferredContentSize));
        _rowCount = 1;
        [_myTableView reloadData];
    }else {
        self.preferredContentSize = CGSizeMake(_defaultSize.width,_defaultSize.height * 3);
        NSLog(@"size3:%@",NSStringFromCGSize(self.preferredContentSize));
        _rowCount = 3;
        [_myTableView reloadData];
    }
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.

    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData
    completionHandler(NCUpdateResultNoData);
    //completionHandler(NCUpdateResultNewData);
}

#pragma mark - tableview dataSource & delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _rowCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * ID = @"cell";
    
    TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"TableViewCell" owner:nil options:nil]lastObject];
    }
    NSString * pageCount;
    switch (indexPath.row) {
        case 0:
            pageCount = @"first";
            break;
        case 1:
            pageCount = @"second";
            break;
        case 2:
            pageCount = @"third";
            break;
        default:
            break;
    }
    cell.cellImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld.jpg",indexPath.row]];
    
    NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.steven.app"];
    NSString * str = [userDefaults objectForKey:@"shareData"];

    cell.cellLabel.text = [NSString stringWithFormat:@"Jump the %@ page-%@",pageCount,str];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return (self.preferredContentSize.height / _rowCount);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"testToday://%ld",indexPath.row]];
    
    [self.extensionContext openURL:url completionHandler:nil];
}
@end
