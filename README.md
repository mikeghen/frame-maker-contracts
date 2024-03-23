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
