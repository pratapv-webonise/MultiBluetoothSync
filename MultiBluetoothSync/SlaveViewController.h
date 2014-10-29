//
//  SlaveViewController.h
//  MultiBluetoothSync
//
//  Created by Mac-4 on 29/10/14.
//  Copyright (c) 2014 WeboniseLab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface SlaveViewController : UIViewController<CBPeripheralManagerDelegate, UITextViewDelegate>
//periferal
@property (strong, nonatomic) CBPeripheralManager *peripheralManager;
@property (strong, nonatomic) CBMutableCharacteristic *transferCharacteristic;
@property (strong, nonatomic) NSData *dataToSend;
@property (nonatomic, readwrite) NSInteger sendDataIndex;
@end
