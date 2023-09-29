# bitcoin-core-handson

OSC2023 Online/Fallの資料になります。

- https://event.ospn.jp/osc2023-online-fall/session/1140877

## コミュニティの紹介

- https://cryptocurrency.connpass.com/

## Dockerビルド

```bash
git clone https://github.com/shu-kob/bitcoin-core-handson
cd bitcoin-core-handson
./build.sh
```

## Bitcoin Core起動

```bash
mkdir ~/.bitcoin
cp bitcoin.conf ~/.bitcoin
```

```bash
docker-compose up
```

- 別のターミナルを開いて下記を実行

```bash
alias bcli="docker exec bitcoin-signet bitcoin-cli"

bcli getblockchaininfo
```

## Signetのブロックチェーンエクスプローラ

- https://mempool.space/signet
音が鳴ります。ご注意ください。

- https://ex.signet.bublina.eu.org/

最新ブロックに同期できると送金ができます。

## ウォレット作成

```bash
bcli createwallet "handson"

bcli listwallets
```

```bash
bcli getnewaddress
```

それぞれの環境によって出力されるアドレスは異なります。

```
tb1quyw5pweu2g3l9vk8evpdtwpyk9j7vz2x0nkpcg
```

## SignetのFaucet

Faucetからテストコインを調達
同期を待つ間、FaucetからSignet BTCを調達

- https://signet.bc-2.jp/
- https://alt.signetfaucet.com/

## トランザクション情報の取得

ブロック同期が終わった後、下記を実行

```bash
bcli getrawtransaction 393e068a34f0060125757a9d24e23513ad24bc0847b4a053431c97c3e38e5030
```

最新ブロックまで同期できていなければ、下記エラーが出力されます

```
error code: -5
error message:
No such mempool or blockchain transaction. Use gettransaction for wallet transactions.
```
