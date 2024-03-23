## Frame Maker Contracts
Frame Maker is a tool for making Farcaster Frames from _Frame Templates_. This repo contains the contracts.

## Usage

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```

### Gas Snapshots

```shell
$ forge snapshot
```

### Anvil

```shell
$ anvil
```

### Deploy

```shell
$ export PRIVATE_KEY=0x...
$ export OWNER=0x...
$ forge script script/FrameMakerDeploy.s.sol:FrameMakerDeploy --rpc-url <rpc-url>
```

### Cast

```shell
$ cast <subcommand>
```

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```


## Deployment Addresses

### Base Sepolia 
Factory: 0xC46e61C0E92D7d66E7185a8f1eb3726294a4DB9E
Gate Token: 0x8801ED4695035aaCFf23b93559932D91db713f2E
Frame Token: 0x38176833c35d86beF7E0fef2eab7b7e352494F04
