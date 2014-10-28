//
//  ViewController.m
//  MultiBluetoothSync
//
//  Created by Mac-4 on 21/10/14.
//  Copyright (c) 2014 WeboniseLab. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "WebClient.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    pickerData = @[@"1x1", @"2 x 2", @"4 x 4", @"6 x 6", @"8 x 8", @"10 x 10"];
    pickerModeArray = @[@"Portrait",@"Landscape"];
}


- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}


#pragma mark
#pragma btton clicked action

-(IBAction)displayDevicePickerClicked:(id)sender{
    if(!pickerView){
    pickerView = [[[NSBundle mainBundle] loadNibNamed:@"popUpView" owner:self options:nil] lastObject];
    pickerView.frame = CGRectMake(0, 100, 320, 250);
    [self.view addSubview:pickerView];
    }
    else{
        pickerView.hidden = NO;
    }
}

-(IBAction)pickerCloseBtnClicked:(id)sender{
    pickerView.hidden = YES;
}

#pragma mark
#pragma Picker Delegates


-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    int ret = 0;
    if(component==0){
        ret = pickerData.count;
    }
    else{
        ret = pickerModeArray.count;
    }
    return ret;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSArray *ret ;
    if(component==0){
        ret = pickerData;
    }
    else{
        ret = pickerModeArray;
    }
    return ret[row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSString *finalString = [NSString stringWithFormat:@"SELECTED MESH TYPE : %@ - %@",pickerData[row],pickerModeArray[component]];
    _userDeviceChoiceLabel.text = finalString;
   
}

@end
