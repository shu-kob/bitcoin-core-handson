# bitcoin-core-handson

2023年9月30日(土)に行われたOSC2023 Online/Fallの資料になります。

- セミナー情報: https://event.ospn.jp/osc2023-online-fall/session/1140877

## コミュニティの紹介

- 日本暗号通貨ユーザ会
  - https://cryptocurrency.connpass.com/

## 変更点

SignetというTestnetの一つを使用する予定でしたが、Regtestを使用します。

昔、[OSCでSignetを使った同様のハンズオン](https://qiita.com/shu-kob/items/488b291ce40fbc398c3c)を行い、<br>
その際は大丈夫だったのですが、Signetのブロックチェーンサイズが大きくなり、同期に時間がかかるようになりました、

そのため、スタンドアロンで使用できるRegtestを使用します。

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
alias bcli="docker exec bitcoin-core bitcoin-cli"

bcli getblockchaininfo
```

```
{
  "chain": "regtest",
  "blocks": 0,
  "headers": 0,
  "bestblockhash": "0f9188f13cb7b2c71f2a335e3a4fc328bf5beb436012afca590b1a11466e2206",
  "difficulty": 4.656542373906925e-10,
  "time": 1296688602,
  "mediantime": 1296688602,
  "verificationprogress": 1,
  "initialblockdownload": true,
  "chainwork": "0000000000000000000000000000000000000000000000000000000000000002",
  "size_on_disk": 293,
  "pruned": false,
  "warnings": ""
}
```

## ウォレット作成

```bash
bcli createwallet "handson"
```

```
{
  "name": "handson"
}
```

```bash
bcli getnewaddress
```

それぞれの環境によって出力されるアドレスは異なります。

```
bcrt1quv0py9swzt7hr5q0mwtjxm0f0jnp2nmu8x8l8u
```

## マイニング

```bash
bcli generatetoaddress 101 bcrt1quv0py9swzt7hr5q0mwtjxm0f0jnp2nmu8x8l8u
```

マイニングで得た報酬は100ブロック経過するまでロックされて使えません

```
[
  "7bd3a6a097f0729ce0cdce42715cfec4b0007c33abb8829d1a9727180df3925e",
  "37c7d69a344cdfa0ef0ba6de9db4fcb0d7456c738d220a6d7656696b9e396ba9",
  "21dff59299e87089a655bd75a2997e32f0689822133e30634f24c176c96fbc5d",
  "07045bb72b2220a03a51842b878fc256fe4205cbfffc36ba912d1508b4bb8adc",
  "4cffa7715ef7a34e9a7182148ca4e212427265c1f95ba69e46665d3d34c5f1ea",
  "311c3ecbbef1ef646174b47444866058dcc7a413c098ff1aee7d5da7789f997f",
  "1e062df8f9165808e0be388220e1a7514c28395e658f4c581151e0ab75b70f8a",
  "4425e66f9848432138dcd61d9f418190c5cf8f1855d7a7d83203b1a9e0277d45",
  "7573baecdc4d5df488c33688dad2795a1de3ffdadf4d2c1b14e6361c2dd56157",
  "4633580c70721db6d5b5cca0bb7c51611967086726415a293810f5d8080d2bd9",
  "1053449aef503788ade0d5c19d9a573158fa05c19c11aba51355ee945f91d09d",
  "2eedfe774284cb011d25151117ef031db2301662dd594aa21834065828ee5d40",
  "37e6ce0e8a78d9808bb710d26a0793b445ba15fb18f65c00757fc9153ed12e18",
  "1b1fb1943d6f5b4e3d0c16cdf9aa50087376c55241da63abf67ee045ce4696a0",
  "5bc1ba91f05f960718a8b3d0c255cefd7717011e568332964a0ef5b9f0a0de1c"
  〜略〜
]
```

```bash
bcli getbalance
```

```
50.00000000
```

```bash
bcli getblockchaininfo
```

```
{
  "chain": "regtest",
  "blocks": 101,
  "headers": 101,
  "bestblockhash": "2de314b26567a53749c0db86bf252e35784465146fa16be6bae6b93e9c4ab1c4",
  "difficulty": 4.656542373906925e-10,
  "time": 1696005560,
  "mediantime": 1696005559,
  "verificationprogress": 1,
  "initialblockdownload": false,
  "chainwork": "00000000000000000000000000000000000000000000000000000000000000cc",
  "size_on_disk": 30375,
  "pruned": false,
  "warnings": ""
}
```

## 送金

```bash
bcli getnewaddress
```

```
bcrt1qtm2kjrza7w8n28v8uv8yxr74ruvpf3d8tvlxsq
```

```bash
bcli sendtoaddress bcrt1qtm2kjrza7w8n28v8uv8yxr74ruvpf3d8tvlxsq 32
```

```
4ffe8e6bd91b8baa7014a6f77b29cdf6b94d322d8c4e648eecf22569dd3c3fcb
```

## トランザクション情報の取得

```bash
bcli getrawtransaction 4ffe8e6bd91b8baa7014a6f77b29cdf6b94d322d8c4e648eecf22569dd3c3fcb
```

```
02000000000101e08b48b477993e1262369f6be5398085ab0796d39663b76896f562125c4be72b0000000000fdffffff0273d1496b00000000160014c75ddd104e58a10b6d5944c0118e001bdefa92730020bcbe000000001600145ed5690c5df38f351d87e30e430fd51f1814c5a70247304402207f469ae3799c2a9e50decd7c1a935c60b9bc3021b85867116de386f2cf484a6402205dc40fceb89621462424f3647d02d99f11c491a4bc00e928c9e6e204c1a13dcf012103255940dd57634678d4ade5a5108c0e5e4386c1db314df9ef38f6b438c4610e4d65000000
```

```bash
bcli decoderawtransaction 02000000000101e08b48b477993e1262369f6be5398085ab0796d39663b76896f562125c4be72b0000000000fdffffff0273d1496b00000000160014c75ddd104e58a10b6d5944c0118e001bdefa92730020bcbe000000001600145ed5690c5df38f351d87e30e430fd51f1814c5a70247304402207f469ae3799c2a9e50decd7c1a935c60b9bc3021b85867116de386f2cf484a6402205dc40fceb89621462424f3647d02d99f11c491a4bc00e928c9e6e204c1a13dcf012103255940dd57634678d4ade5a5108c0e5e4386c1db314df9ef38f6b438c4610e4d65000000
```

```
{
  "txid": "4ffe8e6bd91b8baa7014a6f77b29cdf6b94d322d8c4e648eecf22569dd3c3fcb",
  "hash": "495d936d538cddab245516be6d0d4a6f4d10d9ea3a09452a48bee23762d5c152",
  "version": 2,
  "size": 222,
  "vsize": 141,
  "weight": 561,
  "locktime": 101,
  "vin": [
    {
      "txid": "2be74b5c1262f59668b76396d39607ab858039e56b9f3662123e9977b4488be0",
      "vout": 0,
      "scriptSig": {
        "asm": "",
        "hex": ""
      },
      "txinwitness": [
        "304402207f469ae3799c2a9e50decd7c1a935c60b9bc3021b85867116de386f2cf484a6402205dc40fceb89621462424f3647d02d99f11c491a4bc00e928c9e6e204c1a13dcf01",
        "03255940dd57634678d4ade5a5108c0e5e4386c1db314df9ef38f6b438c4610e4d"
      ],
      "sequence": 4294967293
    }
  ],
  "vout": [
    {
      "value": 17.99999859,
      "n": 0,
      "scriptPubKey": {
        "asm": "0 c75ddd104e58a10b6d5944c0118e001bdefa9273",
        "desc": "addr(bcrt1qcawa6yzwtzsskm2egnqprrsqr0004ynn5q55aq)#j75jnnyt",
        "hex": "0014c75ddd104e58a10b6d5944c0118e001bdefa9273",
        "address": "bcrt1qcawa6yzwtzsskm2egnqprrsqr0004ynn5q55aq",
        "type": "witness_v0_keyhash"
      }
    },
    {
      "value": 32.00000000,
      "n": 1,
      "scriptPubKey": {
        "asm": "0 5ed5690c5df38f351d87e30e430fd51f1814c5a7",
        "desc": "addr(bcrt1qtm2kjrza7w8n28v8uv8yxr74ruvpf3d8tvlxsq)#mududn2e",
        "hex": "00145ed5690c5df38f351d87e30e430fd51f1814c5a7",
        "address": "bcrt1qtm2kjrza7w8n28v8uv8yxr74ruvpf3d8tvlxsq",
        "type": "witness_v0_keyhash"
      }
    }
  ]
}
```

## 続き

マイニングしたり、送金したり、トランザクションの中身を見てみましょう。

```bash
bcli help
```
