//
//  HPBaseWKWebViewController.m
//  ZHDJ
//
//  Created by 秦正华 on 2017/10/31.
//  Copyright © 2017年 Hopex. All rights reserved.
//

#import "HPBaseWKWebViewController.h"
#import <WebKit/WebKit.h>
static void *WKWebBrowserContext = &WKWebBrowserContext;

@interface HPBaseWKWebViewController () <WKNavigationDelegate>
@property(nonatomic,strong)WKWebView *contentWebView;
@property(nonatomic,strong)UIProgressView *progressView;

@end

@implementation HPBaseWKWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.contentWebView];
    [self.view addSubview:self.progressView];
    [self layoutConstraints];
    
}

-(void)setUrlStr:(NSString *)urlStr
{
    _urlStr = urlStr;
    [self loadData];
}

-(void)setHtmlStr:(NSString *)htmlStr
{
    _htmlStr = htmlStr;
    [self loadData];
}

- (void)layoutConstraints {
    [self.contentWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(64, 0, 0, 0));
    }];
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(64);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(2);
    }];
}

- (void)loadData {
    if (self.urlStr.length) {
        NSURL* url=[NSURL URLWithString:self.urlStr relativeToURL:[NSURL URLWithString:@"http://"]];
        NSURLRequest *request =[NSURLRequest requestWithURL:url];
        [self.contentWebView loadRequest:request];
        return;
    }
    if (self.htmlStr.length) {
        [self.contentWebView loadHTMLString:self.htmlStr baseURL:nil];
        return;
    }
}

- (void)leftBtnAction {
    //TODO:网页内可以返回
    if ([self.contentWebView canGoBack]) {
        [self.contentWebView goBack];
    }else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}


#pragma mark - WKNavigationDelegate
//开始加载
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    //开始加载的时候，让加载进度条显示
    self.progressView.hidden = NO;
}

//网页加载完成
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    // 获取加载网页的标题
    self.navigationItem.title = self.contentWebView.title;
}
//内容返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
}

//服务器请求跳转的时候调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
}

// 内容加载失败时候调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error{
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    //如果是跳转一个新页面
    if (navigationAction.targetFrame == nil) {
        [webView loadRequest:navigationAction.request];
    }
    NSURL *URL = navigationAction.request.URL;
    [self dealSomeThing:URL];
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)dealSomeThing:(NSURL *)url{
    NSString *scheme = [url scheme];
    NSString *resourceSpecifier = [url resourceSpecifier];
    if ([scheme isEqualToString:@"tel"]) {
        NSString *callPhone = [NSString stringWithFormat:@"tel://%@", resourceSpecifier];
        /// 防止iOS 10及其之后，拨打电话系统弹出框延迟出现
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone]];
        });
    }
}

//进度条
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView {
}

//KVO监听进度条
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(estimatedProgress))] && object == self.contentWebView) {
        [self.progressView setAlpha:1.0f];
        BOOL animated = self.contentWebView.estimatedProgress > self.progressView.progress;
        [self.progressView setProgress:self.contentWebView.estimatedProgress animated:animated];
        
        // Once complete, fade out UIProgressView
        if(self.contentWebView.estimatedProgress >= 1.0f) {
            [UIView animateWithDuration:0.3f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                [self.progressView setAlpha:0.0f];
            } completion:^(BOOL finished) {
                [self.progressView setProgress:0.0f animated:NO];
            }];
        }
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - getters and setters
- (WKWebView *)contentWebView {
    if (!_contentWebView) {
        _contentWebView = [[WKWebView alloc] init];
        _contentWebView.backgroundColor = [UIColor whiteColor];
        _contentWebView.opaque = YES;
        //适应你设定的尺寸
        [_contentWebView sizeToFit];
        _contentWebView.scrollView.showsVerticalScrollIndicator = NO;
        // 设置代理
        _contentWebView.navigationDelegate = self;
        //kvo 添加进度监控
        [_contentWebView addObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress)) options:0 context:WKWebBrowserContext];
        
        //设置网页的配置文件
        WKWebViewConfiguration * Configuration = [[WKWebViewConfiguration alloc]init];
        // 此处一定要做判断，因为是iOS9之后才有的方法，否则在iOS8下会崩溃
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0) {
            //允许视频播放
            Configuration.allowsAirPlayForMediaPlayback = YES;
            // 允许在线播放
            Configuration.allowsInlineMediaPlayback = YES;
            //开启手势触摸 默认设置就是NO。在ios8系统中会导致手势问题，程序崩溃
            _contentWebView.allowsBackForwardNavigationGestures = YES;
        }
        // 允许可以与网页交互，选择视图
        Configuration.selectionGranularity = YES;
        // web内容处理池
        Configuration.processPool = [[WKProcessPool alloc] init];
        //自定义配置,一般用于 js调用oc方法(OC拦截URL中的数据做自定义操作)
        WKUserContentController * UserContentController = [[WKUserContentController alloc]init];
        // 是否支持记忆读取
        Configuration.suppressesIncrementalRendering = YES;
        // 允许用户更改网页的设置
        Configuration.userContentController = UserContentController;
    }
    return _contentWebView;
}

- (UIProgressView *)progressView {
    if (!_progressView) {
        _progressView = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
        [_progressView setTrackTintColor:[UIColor whiteColor]];
        _progressView.progressTintColor = [UIColor blueColor];
    }
    return _progressView;
}

// 记得dealloc
- (void)dealloc {
    [self.contentWebView removeObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress))];
}


@end
