//
//  VideoViewController.h
//  MultiBluetoothSync
//
//  Created by Mac-4 on 28/10/14.
//  Copyright (c) 2014 WeboniseLab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoViewController : UIViewController<UIWebViewDelegate>
@property(nonatomic,strong) IBOutlet UIWebView *webView;
@property(nonatomic,strong) NSDictionary *dictionary;
@property(nonatomic,strong)IBOutlet UILabel *titleLabel;
@end
