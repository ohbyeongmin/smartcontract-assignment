const { expect } = require("chai");
const { loadFixture } = require("@nomicfoundation/hardhat-network-helpers");

describe("OBMToken contract", function () {
    async function deployTokenFixture() {
        const OBMToken = await ethers.getContractFactory("OBMToken");
        const [owner, burner, addr1, addr2] = await ethers.getSigners();

        const hardhatOBMToken = await OBMToken.deploy();

        await hardhatOBMToken.deployed();

        return { OBMToken, hardhatOBMToken, owner, burner, addr1, addr2 };
    }

    // 배포 테스트 :
    //  1. 배포 후 owner 가 일치하는지 확인
    describe("Deployment", function () {
        it("Should set the right owner", async function () {
            const { hardhatOBMToken, owner } = await loadFixture(
                deployTokenFixture
            );
            expect(await hardhatOBMToken.owner()).to.equal(owner.address);
        });
    });

    // Mint 테스트 :
    //  1. addr1 은 owner 가 아니기 때문에 mint 를 호출 할 수 없음
    //  2. owner 는 mint 를 호출 할 수 있음
    describe("Mint test", function () {
        it("Should be called by the owner", async function () {
            const { hardhatOBMToken, owner, addr1 } = await loadFixture(
                deployTokenFixture
            );

            await expect(
                hardhatOBMToken.connect(addr1).mint(owner.address, 10000000)
            ).to.be.reverted;

            await expect(
                hardhatOBMToken.connect(owner).mint(owner.address, 10000000)
            ).not.to.be.reverted;
        });
    });

    // Burn 테스트 :
    // 1. addr2 는 토큰 소유자도 아니고 승인된 주소도 아니라 burn 을 호출 할 수 없음.
    // 2. burner 는 토큰은 없지만 승인된 주소라 burn 을 호출 할 수 있음.
    // 3. addr1 는 승인된 주소는 아니지만 토큰을 소유하기 때문에 burn 을 호출 할 수 있음.
    describe("Burn test", function () {
        it("Should be called by the owner or burner", async function () {
            const { hardhatOBMToken, owner, burner, addr1, addr2 } =
                await loadFixture(deployTokenFixture);

            await hardhatOBMToken.connect(owner).mint(owner.address, 10000);
            await hardhatOBMToken
                .connect(owner)
                .setupBurnerRole(burner.address);
            await hardhatOBMToken.connect(owner).transfer(addr1.address, 10);

            await expect(hardhatOBMToken.connect(addr2).burn(addr1.address, 1))
                .to.be.reverted;
            await expect(hardhatOBMToken.connect(burner).burn(addr1.address, 1))
                .not.to.be.reverted;
            await expect(hardhatOBMToken.connect(addr1).burn(addr1.address, 1))
                .not.to.be.reverted;
        });
    });
});
