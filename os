package main

import (
	"fmt"
	"os"

	"github.com/terra-project/terra.go/client"
	"github.com/terra-project/terra.go/key"
	"github.com/terra-project/terra.go/msg"
)

func main() {
	// 创建 Terra 客户端
	c := client.New("https://lcd.terra.dev")

	// 设置发送者私钥
	mnemonic := "your mnemonic here"
	senderKey, err := key.NewMnemonicKey(mnemonic)
	if err != nil {
		fmt.Println("Error creating sender key:", err)
		os.Exit(1)
	}

	// 设置接收者地址
	recipientAddress := "terra1abcde...12345"

	// 设置转账金额
	amount := "1000000" // 1 TON

	// 构造转账消息
	sendMsg := msg.Send{
		FromAddress: senderKey.GetAddress(),
		ToAddress:   recipientAddress,
		Amount:      amount,
		Denom:       "uluna",
	}

	// 签名和广播交易
	txHash, err := c.SendTx(senderKey, []msg.Msg{sendMsg}, nil, "")
	if err != nil {
		fmt.Println("Error sending transaction:", err)
		os.Exit(1)
	}

	fmt.Println("Transaction sent, hash:", txHash)
}
