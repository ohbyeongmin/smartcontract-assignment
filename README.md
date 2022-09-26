# SmartContract Assignment

## contract-1

openzepplein 이용(상속)해서 ERC20 토큰 만들기

-   [ ] mintable (owner만 가능)
-   [ ] burnable (토큰 소유자 또는 승인된 주소만 가능)
-   [ ] snapshot (누구나 가능)

---

## contract-2

ERC721 컨트랙 만들기

-   [ ] id는 순서대로 증가합니다.
-   [ ] mint 는 누구나 가능합니다.
-   [ ] mint 는 1분에 10개까지만 생성될 수 있습니다.
-   [ ] 메타데이타 (tokenURL)는 아래와 같이 나오게

```json
"name": "Egg Head",
"description": "A new NFT collection",
"image": "data:image/svg+xml;base64,INSERT_YOUR_BASE64_ENCODED_SVG_HERE"
```

참고 : INSERT_YOUR_BASE64_ENCODED_SVG_HERE

```svg
<svg xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMinYMin meet" viewBox="0 0 350 350">

 <style>.base { fill: white; font-family: serif; font-size: 14px; }</style>
 <rect width="100%" height="500%" fill="grey" />
 <text x="50%" y="50%" class="base" dominant-baseline="middle" text-anchor="middle">아이디 표시, 별명입력</text>
</svg>
```

참고 : https://blog.cryptostars.is/how-to-build-dynamically-generating-svg-nfts-on-chain-f6a24423ea29

---

## contract-3

뱅킹의 통장 컨트랙 만들기

-   [ ] 사용자는 ERC20 토큰을 예치하고, 이자로 ERC20 토큰을 제공받을 수 있습니다.
-   [ ] 토큰은 [contract-1] 에서 만든 ERC20 토큰을 사용합니다.
-   [ ] 구현하는 기능은 아래와 같습니다.
    -   예치하기
    -   이자받기
    -   인출하기

---

## contract-4

[contract-3] 에서 만든 컨트랙이 업그레이드 가능해야 합니다

-   [ ] 배포 후 함수를 추가/삭제할 수 있게 해주세요 ( 로직을 변경할 수 있습니다. 또는 특정 함수를 사용할 수 없도록 할 수 있습니다. 또는 특정 함수만 추가할 수 있습니다.)
-   [ ] 업그레이드 후, 별도의 데이타 마이그레이션은 하지 않도록 해주세요.

---

## contract-5

[contract-4] 에서 만든 컨트랙을 팩토리 컨트랙을 통해 편하게 배포할 수 있도록 해주세요.

-   [ ] 배포된 컨트랙을 조회할 수 있어야 합니다.
-   [ ] 여러개의 컨트랙을 배포할 수 있어야 합니다.

---

## contract-6

[contract-5] 를 통해서 배포한 모든 통장 컨트랙의 기본 로직을 변경할 수 있게 해주세요.

-   [ ] 각각의 컨트랙의 기본 로직이 아닌, 특수하게 함수를 추가하거나, 삭제한 것은 변경되지 않고, 기본 로직만 변경합니다.
