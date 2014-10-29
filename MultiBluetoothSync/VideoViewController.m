//
//  VideoViewController.m
//  MultiBluetoothSync
//
//  Created by Mac-4 on 28/10/14.
//  Copyright (c) 2014 WeboniseLab. All rights reserved.
//

#import "VideoViewController.h"

@interface VideoViewController ()

@end

@implementation VideoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
       
    }
    return self;
}

-(NSString *)getUrl{
    NSString *str;
    
    str = _dictionary[@"id"][@"$t"];
    NSArray *parts = [str componentsSeparatedByString:@"/"];
    NSString *filename = [parts objectAtIndex:[parts count]-1];
    return filename;
}
-(void)loadPreviewVideo:(NSString *)url{
    
    [self.webView setAllowsInlineMediaPlayback:YES];
    [self.webView setMediaPlaybackRequiresUserAction:NO];
    [self.view addSubview:self.webView];
    self.webView.delegate = self;
    
    NSString* embedHTML = [NSString stringWithFormat:@"\
                           <html>\
                           <body style='margin:0px;padding:0px;'>\
                           <script type='text/javascript' src='http://www.youtube.com/iframe_api'></script>\
                           <script type='text/javascript'>\
                           function onYouTubeIframeAPIReady()\
                           {\
                           ytplayer=new YT.Player('playerId',{events:{onReady:onPlayerReady}})\
                           }\
                           function onPlayerReady(a)\
                           { \
                           a.target.playVideo(); \
                           }\
                           </script>\
                           <iframe id='playerId' type='text/html'  width=\"100%%\" height=\"100%%\" src='http://www.youtube.com/embed/%@?enablejsapi=1&rel=0&playsinline=1&autoplay=1' frameborder='0'>\
                           </body>\
                           </html>", url];
    
    [self.webView loadHTMLString:embedHTML baseURL:[[NSBundle mainBundle] resourceURL]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
     [self loadPreviewVideo:[self getUrl]];
    
    _titleLabel.text = _dictionary[@"title"][@"$t"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
