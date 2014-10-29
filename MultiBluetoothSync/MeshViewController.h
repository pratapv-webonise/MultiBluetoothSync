//
//  MeshViewController.h
//  MultiBluetoothSync
//
//  Created by Mac-4 on 28/10/14.
//  Copyright (c) 2014 WeboniseLab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface MeshViewController : UIViewController<CBCentralManagerDelegate,CBPeripheralDelegate,CBPeripheralManagerDelegate,UIWebViewDelegate>{
    
    IBOutlet UILabel *s1Status;
    IBOutlet UILabel *s2Status;
    IBOutlet UILabel *s1ConnectedDeviceNumberLabel;
    IBOutlet UILabel *s2ConnectedDeviceNumberLabel;
    
    IBOutlet UILabel *s1LevelLabel;
    IBOutlet UILabel *s2LevelLabel;
    
    IBOutlet UILabel *playTimeLabel;
    IBOutlet UILabel *bufferedDataLabel;
    
    //bool
    BOOL isS1Connected;
    BOOL isS2Connected;
}

@property(nonatomic,strong) IBOutlet UIWebView *webView;

//central
@property (strong,nonatomic) CBCentralManager *centralManager;
@property (nonatomic,strong) CBPeripheral *discoveredPeripheral_1;
@property (nonatomic,strong) CBPeripheral *discoveredPeripheral_2;
@property (strong,nonatomic) NSMutableData *data;
@property (strong,nonatomic) NSMutableArray *detectedDevices;

//periferal
@property (strong,nonatomic) CBPeripheralManager *peripheralManager;
@property (strong,nonatomic) CBMutableCharacteristic *transferCharacteristic;
@property (strong,nonatomic) NSData *dataToSend;
@property (nonatomic,readwrite) NSInteger sendDataIndex;

@end
