#  BASYS3 VHDLサンプル

## ■概要
BASYS3(Artix-7 FPGAボード) に 以下の超音波距離センサーを接続して 距離計測
するためのVHDLソース。

* 超音波距離センサー HC-SR04 : <https://akizukidenshi.com/catalog/g/g111009/>
* Basys3 with AMD Artix 7 FPGA Board : <https://japan.xilinx.com/products/boards-and-kits/1-54wqge.html>

## ■接続
| BASYS3 | HC-SR04 |
|:---|:---|
| JC7       | Trig |
| JC8       | Echo |
| JC11      | GND  |
| JC12      | Vcc  |

## ■内容/操作
超音波距離センサーを接続。サンプルをFPGAデバイスに書込むと、以下のように動作する。

* BTND押下: 距離計測 (計測結果は 7segLEDに出力される)
* BTNC押下: 表示内容リセット

距離計測結果は [cm]単位です。

1[cm]分のパルスを 100[MHz]のCLKを5800分周して作っています。この作成し
たCLKを10進カウンタの入力に使用しています。

10進カウンタ(4桁分)の出力は 7segLEDで表示されます。7segLEDはダイナミ
ック点灯方式で制御しています。
