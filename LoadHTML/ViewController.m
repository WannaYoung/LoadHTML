//
//  ViewController.m
//  LoadHTML
//
//  Created by yang on 16/5/3.
//  Copyright © 2016年 yang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.webView.delegate = self;
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"html" ofType:@"html"];
    
    NSString *htmlString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    [self.webView loadHTMLString:htmlString baseURL:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
}

-(void)webViewDidFinishLoad:(UIWebView*)webView
{
    NSString *maxWidth = [NSString stringWithFormat:@"var script = document.createElement('script');"
                          "script.type = 'text/javascript';"
                          "script.text = \"function ResizeImages() { "
                          "var myimg,oldwidth;"
                          "var maxwidth = %.2f;" // UIWebView中显示的图片宽度
                          "for(i=0;i <document.images.length;i++){"
                          "myimg = document.images[i];"
                          "if(myimg.width > maxwidth){"
                          "oldwidth = myimg.width;"
                          "myimg.width = maxwidth;"
                          "}"
                          "}"
                          "}\";"
                          "document.getElementsByTagName('head')[0].appendChild(script);",[UIScreen mainScreen].bounds.size.width - 20];
    
    [self.webView stringByEvaluatingJavaScriptFromString:maxWidth];
    
    [self.webView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error
{
    
}

@end
