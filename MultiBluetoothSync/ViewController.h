//
//  ViewController.h
//  MultiBluetoothSync
//
//  Created by Mac-4 on 21/10/14.
//  Copyright (c) 2014 WeboniseLab. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ViewController : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource>
{
    NSArray *pickerData;
    NSArray *pickerModeArray;
    UIView *pickerView;
}
@property(nonatomic) int numberOfDevices;
@property(nonatomic,strong) IBOutlet UIButton *displayDevicePicker;
@property(nonatomic,strong) IBOutlet UIView *popUpView;
@property(nonatomic,strong) IBOutlet UIPickerView *picker;
@property(nonatomic,strong) IBOutlet UIButton *pickerCloseBtn;
@property(nonatomic,strong) IBOutlet UILabel *userDeviceChoiceLabel;
@property(nonatomic,strong) IBOutlet UIButton *startMeshBtn;

-(IBAction)displayDevicePickerClicked:(id)sender;
-(IBAction)pickerCloseBtnClicked:(id)sender;
-(IBAction)startMeshBtnClick:(id)sender;
@end
