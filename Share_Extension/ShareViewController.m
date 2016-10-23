//
//  ShareViewController.m
//  Share_Extension
//
//  Created by 郭艾超 on 16/10/23.
//  Copyright © 2016年 Steven. All rights reserved.
//

#import "ShareViewController.h"

@interface ShareViewController ()

@end

@implementation ShareViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    dispatch_sync(dispatch_get_global_queue(0, 0), ^{
        NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.steven.app"];
        [userDefaults setObject:self.contentText forKey:@"shareText"];
        
        NSExtensionItem * item = self.extensionContext.inputItems.firstObject;
        
        NSItemProvider * provider =item.attachments.firstObject;
        [provider loadPreviewImageWithOptions:nil completionHandler:^(id<NSSecureCoding>  _Nullable item, NSError * _Null_unspecified error) {
            NSData * data = UIImagePNGRepresentation((UIImage *)item);
            [userDefaults setObject:data forKey:@"shareImage"];
        }];
        
        NSString * dataType = provider.registeredTypeIdentifiers.firstObject;
        [provider loadItemForTypeIdentifier:dataType options:nil completionHandler:^(id<NSSecureCoding>  _Nullable item, NSError * _Null_unspecified error) {
            NSString * url = [NSString stringWithFormat:@"%@",item];
            [userDefaults setObject:url forKey:@"shareURL"];
        }];
        [userDefaults synchronize];
    });
}

- (BOOL)isContentValid {
    // Do validation of contentText and/or NSExtensionContext attachments here
    NSInteger maxLength = 66;
    NSInteger length = self.contentText.length;
    self.charactersRemaining = @(maxLength - length);
    if (self.charactersRemaining.integerValue > 0) {
        return YES;
    }else {
        return NO;
    }
}

- (void)didSelectPost {
    // This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.
    
    // Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
    //[self.extensionContext completeRequestReturningItems:@[] completionHandler:nil];
    NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.steven.app"];
    [userDefaults setBool:YES forKey:@"isShare"];
    [userDefaults synchronize];
}

- (NSArray *)configurationItems {
    // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
    return @[];
}


@end
