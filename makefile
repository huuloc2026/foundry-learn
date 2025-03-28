-include .env

deploy-anvil:;
	@forge script script/DeploySimpleStorage.s.sol --rpc-url http://127.0.0.1:8545 --broadcast --account jake-anvil

deploy-sepolia:;
	@forge script script/DeploySimpleStorage.s.sol --rpc-url ${SEPOLIA_RPC_URL} --broadcast --account jake-foundry-sepolia --verify --etherscan-api-key ${ETHERSCAN_API_KEY}