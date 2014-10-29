//
//  MeshViewController.m
//  MultiBluetoothSync
//
//  Created by Mac-4 on 28/10/14.
//  Copyright (c) 2014 WeboniseLab. All rights reserved.
//

#import "MeshViewController.h"
#define TRANSFER_SERVICE_UUID           @"c6e00bee-5526-4d34-9efd-85b1e4562c4b"
#define TRANSFER_CHARACTERISTIC_UUID    @"0ae55ad5-4f16-4d41-8487-e7dd7e945f83"
#define NOTIFY_MTU 20

@interface MeshViewController ()

@end

@implementation MeshViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    _detectedDevices = [[NSMutableArray alloc]initWithCapacity:2];
    
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updatePeriferalStatus) userInfo:nil repeats:YES];
    
    //start central
    dispatch_queue_t centralQueue = dispatch_queue_create("mycentralqueue", DISPATCH_QUEUE_SERIAL);
    _centralManager = [[CBCentralManager alloc]initWithDelegate:self queue:centralQueue];
    
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

#pragma mark
#pragma CENTRAL DELEGATE METHODS

-(void)centralManagerDidUpdateState:(CBCentralManager *)central{
    if(central.state!=CBCentralManagerStatePoweredOn){
        NSLog(@"Bluetooth service is off...");
        return;
    }
    else
    if(central.state ==CBCentralManagerStatePoweredOn){
        NSLog(@"Bluetooth service is working...");
        NSLog(@"Scanning for devices.....");
        [_centralManager scanForPeripheralsWithServices:@[[CBUUID UUIDWithString:TRANSFER_SERVICE_UUID]] options:@{ CBCentralManagerScanOptionAllowDuplicatesKey : @YES }];
    }
}

-(void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI{
    
    peripheral.delegate = self;
    for (CBPeripheral *storedPeriferal in _detectedDevices) {
        if(storedPeriferal!=peripheral && _detectedDevices.count <= 2){
            [_centralManager connectPeripheral:peripheral options:nil];
        }
    }
    
    if(peripheral!=_discoveredPeripheral_1 && peripheral!= _discoveredPeripheral_2){
        _discoveredPeripheral_1 = peripheral;
    }
    else if(_discoveredPeripheral_1 != nil && _discoveredPeripheral_1!= peripheral && _discoveredPeripheral_2!=peripheral ) {
        _discoveredPeripheral_2 = peripheral;
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)
error{
    if (error) {
        NSLog(@"Error");
        return;
    }
    
    if(_discoveredPeripheral_1==peripheral){
    NSLog(@"Recived Data from s1 ---> %@",characteristic.value);
    }
    else{
        NSLog(@"Recived Data from s2 ---> %@",characteristic.value);
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    
    if (![characteristic.UUID isEqual:[CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_UUID]]) {
        return;
    }
    
    if (characteristic.isNotifying){
    } else{
        [_centralManager cancelPeripheralConnection:peripheral];
    }
}

- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    
    [_centralManager scanForPeripheralsWithServices:@[[CBUUID UUIDWithString:TRANSFER_SERVICE_UUID]] options:@{ CBCentralManagerScanOptionAllowDuplicatesKey : @YES }];
}

#pragma mark
#pragma get Status

-(void)updatePeriferalStatus{
    
    if(!_discoveredPeripheral_1){
        switch (_discoveredPeripheral_1.state){
        case CBPeripheralStateConnected:
             s1Status.text = @"Connected";
            break;
        case CBPeripheralStateConnecting:
             s1Status.text = @"Connecting";
            break;
        default:
             s1Status.text = @"Disconnected";
            break;
        }
    }
    else{
        s1Status.text = @"NA";
    }
    
    if(!_discoveredPeripheral_2){
        switch (_discoveredPeripheral_2.state){
            case CBPeripheralStateConnected:
                s2Status.text = @"Connected";
                break;
            case CBPeripheralStateConnecting:
                s2Status.text = @"Connecting";
                break;
            default:
                s2Status.text = @"Disconnected";
                break;
        }

    }
    else{
       s2Status.text = @"NA";
    }
    
}



@end
