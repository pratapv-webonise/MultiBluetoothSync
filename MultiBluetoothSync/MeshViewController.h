//
//  MeshViewController.h
//  MultiBluetoothSync
//
//  Created by Mac-4 on 28/10/14.
//  Copyright (c) 2014 WeboniseLab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MeshViewController : UIViewController
{
    IBOutlet UILabel *s1Status;
    IBOutlet UILabel *s2Status;
    IBOutlet UILabel *s1ConnectedDeviceNumberLabel;
    IBOutlet UILabel *s2ConnectedDeviceNumberLabel;
    
    IBOutlet UILabel *s1LevelLabel;
    IBOutlet UILabel *s2LevelLabel;
    
    IBOutlet UILabel *playTimeLabel;
    IBOutlet UILabel *bufferedDataLabel;
}

@property(nonatomic,strong) IBOutlet UIWebView *webView;

@end
