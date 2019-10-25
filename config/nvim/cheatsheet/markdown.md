# Block Elements

## Headers 見出し

# 見出し1
## 見出し2
### 見出し3
#### 見出し4
##### 見出し5
###### 見出し6

## Block 段落
空白行を挟むことで段落となります。

段落1

段落2

## Br 改行
改行の前に半角スペース`  `を2つ記述します。

hoge
fuga  
piyo

## Blockquotes 引用
> 引用  
> 引用
>> 多重引用

## Code コード

```
print 'hoge'
```

これは `インラインコード`です。

## pre 整形済みテキスト

    class Hoge
        def hoge
            print 'hoge'
        end
    end

## Hr 水平線

---

# List Elements

## Ul 箇条書きリスト

- リスト1
    - リスト1_1
        - リスト1_1_1
        - リスト1_1_2
    - リスト1_2
- リスト2
- リスト3

## Ol 番号付きリスト

1. 番号付きリスト1
    1. 番号付きリスト1-1
    1. 番号付きリスト1-2
1. 番号付きリスト2
1. 番号付きリスト3

# Span Elements

## Link リンク

[Google](https://www.google.co.jp/)

### 外部参照リンク

[Google][a]

[Yahoo][1]

[a]:http://google.com "Title"
[1]:http://www.yahoo.co.jp


## 強調
### em
これは *イタリック* です  
これは _イタリック_ です

### strong
これは **ボールド** です  
これは __ボールド__ です

### em + strong
これは ***イタリック＆ボールド*** です  
これは ___イタリック＆ボールド___ です

## Images 画像
![代替文字列](URL "タイトル")

```
<img src="attach:cat.jpg" alt="attach:cat" title="attach:cat" width="200" height="200">
```

# Github Flavered Markdown

## Table
| TH1 | TH2 |
----|---- 
| TD1 | TD3 |
| TD | TD4 |


| 左揃え | 中央揃え | 右揃え |
|:---|:---:|---:|
|1 |2 |3 |
|4 |5 |6 |

## Syntax
```php
<?php
  echo 'hello!';
```

## 自動リンク
http://examle.com


## 打ち消し線
~~打ち消し~~

## タスクリスト
- [x] hogehogehgoe
- [x] foofoo

## 絵文字 
  :dog:
## issue番号 
  #123
  @rhysd
