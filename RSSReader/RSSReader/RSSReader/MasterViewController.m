//
//  MasterViewController.m
//  RSSReader
//
//  Created by okitokagechika on 2014/04/16.
//  Copyright (c) 2014年 okito.kagechika. All rights reserved.
//

#import "MasterViewController.h"

#import "DetailViewController.h"

@interface MasterViewController () {
    NSMutableArray *_objects;
}
@end

@implementation MasterViewController{
    //XMLオブジェクト
    TBXML *rssXML;
    //最新ニュースを格納する配列
    NSMutableArray *elementList;
    
    IBOutlet UITableView *table;
    
    //safariに渡すURL
    NSURL *urlForSafari;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    //XMLを取得・解析
    [self getXML];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender
{
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    [_objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Table View

//Table Viewのセクション数を指定
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//Table Viewのセルの数を指定
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [elementList count];
}

//各セルにタイトルを設定
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewsCell" forIndexPath:indexPath];

    UILabel *titleLabel = (UILabel*)[cell viewWithTag:1];
    UILabel *dateLabel = (UILabel*)[cell viewWithTag:2];
    
    //セル上のラベルに記事のタイトルと配信日時を格納
    News *f = [elementList objectAtIndex:[indexPath row]];
    titleLabel.text = f.title;
    dateLabel.text = f.date;
    
    return cell;
}

/*
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = _objects[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}
*/

//HTTP通信を利用してXMLを取得
-(void)getXML{
    NSString *urlString = @"http://rss.dailynews.yahoo.co.jp/fc/rss.xml";
    NSURL *url = [NSURL URLWithString:urlString];
    
    //成功時のコールバック変数
    TBXMLSuccessBlock successBlock = ^(TBXML *tbxmlDucument){
        NSLog(@"「%@」の取得に成功しました。",url);
        //XMLを解析
        [self parseXML];
    };
    
    //失敗時のコールバック関数
    TBXMLFailureBlock failureBlock = ^(TBXML *tbxmlDocument, NSError *error){
        NSLog(@"「%@」の取得に失敗しました。",url);
    };
    
    //ステータスバーのActivity Indicatorの起動
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    //URLで指定したRSSのXMLをバックグラウンドでダウンロード
    rssXML = [TBXML tbxmlWithURL:url success:successBlock failure:failureBlock];
}

//取得したXMLをパース
-(void)parseXML{
    //elementListを初期化
    elementList = [[NSMutableArray alloc] init];
    //XMLの最初の要素<rss>を取得
    TBXMLElement *rssElement = rssXML.rootXMLElement;
    //<rss>以下の<channel>を取得
    TBXMLElement *channelElement = [TBXML childElementNamed:@"channel" parentElement:rssElement];
    //実際のNews項目を記録した<item>を取得
    TBXMLElement *itemElement = [TBXML childElementNamed:@"item" parentElement:channelElement];
    
    //itemの数だけ繰り返し
    while (itemElement) {
        //item以下のtitleを取得
        TBXMLElement *titleElement = [TBXML childElementNamed:@"title" parentElement:itemElement];
        //item以下のlinkを取得
        TBXMLElement *urlElement = [TBXML childElementNamed:@"link" parentElement:itemElement];
        //item以下のpubDateを取得
        TBXMLElement *dateElement = [TBXML childElementNamed:@"pubDate" parentElement:itemElement];
        
        //それぞれの要素のテキスト内容をNSStringとして取得
        NSString *title = [TBXML textForElement:titleElement];
        NSString *url = [TBXML textForElement:urlElement];
        NSString *date = [TBXML textForElement:dateElement];
        
        NSLog(@"title:%@ url:%@", title, url);
        
        //新しいNewsクラスのインスタンスを生成
        News *n = [[News alloc] init];
        
        //nにタイトル、URL、日時を格納
        n.title = title;
        n.url = url;
        n.date = date;
        
        //nをelementListに追加
        [elementList addObject:n];
        
        //次のitemを参照
        itemElement = itemElement->nextSibling;
    }
    
    //バックグラウンドでの処理完了に伴い、フロント側でリストを更新
    [self refreshTableOnFront];
}

//フロント側でテーブルを更新
-(void)refreshTableOnFront{
    [self performSelectorOnMainThread:@selector(refreshTable) withObject:self waitUntilDone:TRUE];
}

//テーブル内容を設定
-(void)refreshTable{
    //ステータスバーのActivity Indicatorを停止
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    //テーブルを最新の内容に
    [table reloadData];
}

//リスト中のお気に入りアイテムが選択されたときの処理
-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //選択された項目のURLを参照
    News *n = [elementList objectAtIndex:[indexPath row]];
    NSString *selectedUrl = n.url;
    
    urlForSafari = [NSURL URLWithString:selectedUrl];
    
    //safariを起動するか確認
    [self goToSafari];
}

//safariを起動するか確認するアラート表示
-(void)goToSafari{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Safariの起動" message:@"このニュースをSafariで開きますか？" delegate:self cancelButtonTitle:@"いいえ" otherButtonTitles:@"はい", nil];
    
    [alert show];
}

//Alert上のはいが押されたとき
-(void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    
    if ([title isEqualToString:@"いいえ"]) {
        NSLog(@"Safari起動キャンセル");
    } else if ([title isEqualToString:@"はい"]) {
        NSLog(@"Safari起動");
        [[UIApplication sharedApplication] openURL:urlForSafari];
    }
}

//フィードを更新
-(IBAction)refreshList:(id)sender{
    //最新のRSSフィードを取得
    [self getXML];
}

@end
