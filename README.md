# 계산기 프로젝트(개인)
작성자: 쿼카

# Queue란?
큐란 대기열이라는 의미이다. 우리가 병원진료할떄 번호표를 뽑고 대기를하면 먼저 오신 손님부터 순서대로 진료를 받는구조와 같이 먼저 들어온 데이터가 먼저나가게되는 구조이다.

# Queue를 구현하는 List 자료구조 방식은 어떤게 좋을까 ?
- Array
[특징]
- 연속적인 메모리위치에 저장되거나 메모리에 연속적인 방식으로 순서대로 저장이된다.
- 배열이 선언되자마자 컴파일 타입에 할당됩니다. 정적메모리 할당
- stack에 할당된다.
[장점]
- 인덱스가 있어 값에 접근하는게 쉽다. O(1)
[단점]
- 배열을 선언할때 크기를 정해야한다.
- 값을 삽입/삭제시 index의 재배치를 해야하는 비효율이 존재함, O(n)

- Linked List
[특징]
- Array에서 삽입/삭제시 index의 재배치를 해야하는 단점을 보안하는 목적으로 만들어졌으며
[data: 0|next: 0x00]->[data: 1|next: 0x01]->[data: 2|next: 0x02]..
이런 방식으로 data와 next라는 다음주소를 가지며 요소들이 서로 연결된 집합이다.
- 새 노드가 추가될때 같이 런타임시 메모리가 할당됩니다. (동적 메모리할당)
- heap과 stack 두 곳에 메모리 할당이된다.
[장점]
- 노드에는 값과 다음 노드를 가르키는 포인터가 존재한다.
- 새 요소를 메모리의 아무곳에나 저장할 수 있다. (포인터만 바꿔주면된다.)

[단점]
- 값을/삽입삭제할때 더 빠르다.
- data와 next그리고 head와 tail까지사용하기때문에 Array에 비해 메모리를 더 많이 사용한다.
- 값을 찾을때 첫번째 인덱스부터 순차적으로 접근해야한다. O(n)


- Deque(Double - Ended Queue 의 줄임말임)
[특징]
- 한쪽에서만 삽입, 다른한쪽에서만 삭제가가능 했떤 큐와 달리 양쪽 front, rear에서 삽입 삭제가 모두 가능한 큐를 의미한다.
[장점]
- 데이터의 삽입 삭제가 빠르고, 앞, 뒤에서 삽입 삭제 모두 가능함
[단점]
- 중간에서의 삽입 삭제가 어려움
- Array는 하나의 배열로 값을 다루지만 더블스택은 reversed된 배열을 하나더 가지게되어 index재배치하는 비효율을 개선해줄 수 있는 방법이다. 시간복잡도도 O(1)


# STEP1 PR 받으면서 배운것들
- 테스트파일을 새로만들었을때 @testable 을 붙여주는이유는 새로운 테스트파일을 만들었을때 생긴 Target은 별도의 모듈로 인식하기때문이다. 코드들이 public, open으로 설정되어있지않는한 접근할 수 없다. 기본적으로 test하는 타입은 Internal타입으로 설계가 되어있어서 외무 타킷이나 모듈에서는 확인할 수 가 없는 상황이다. 그런데 @testable을 사용하게되면 접근 범위에 제한받지않고 모듈에 타킷설정을 해주는 거기 때문에 Internal로 설정된 타입들도 읽어올 수 있다. 꼭 저렇게 해야할까 ? 저렇게 하지않고도 public으로 설정해줄 수도 있겠지만 그러면 불필요한 접근제어 범위를 넓혀 외부에서 접근할 수 있기떄문에 안전하지않다는것이다. 
- CalculateItemQueue내 store프로퍼터 타입은 의존성 주입을 프로토콜로 하는것이 더 유연할 수 있다. 왜냐하면 지금은 자료구조를 LinkedList로 사용하지만 double stack이나 array로 바뀌었다고했을때 프로토콜만 수정하면되고 CalculateItemQueue내부는 수정할 필요가 없기때문이다. 하지만 현재는 제네릭이 들어가있는 상태라서 삽질을 많이 해야할 수도 있어서 메모해놓고 나중에 적용해볼예정이다.
- 테스트할때의 타입별로 파일을 분리하는것이 좋다. 그래야 구분되기 때문.
- 테스트를 위한 테스트코드를 짜면안됩니다. 값을 넣었을때와 안넣었을때 결괏값이 다르면, 즉 분기가될 수 있는 상황이면 케이스를 그에맞게 설정해서 테스트하는것이좋으나 당연한 값이 나오는케이스를 추가하면 안된다. 그리고 기능테스트를 시도했을때 더이상에 테스트할 필요가 없다고 판단되면 굳이 억지로 만들지않고 다른 기능을 테스트하면 될것같다.
- TDD방식은 테스트를 위해 메서드를 추가하는일은 없어야한다. 그래야 테스트를 해도 로직이 변경되지않는 코드라는것을 증명할 수 있기때문이다.
- 제네릭을 사용할때 요소에 calculateItem을 채택시키는 이유
Any 라는 타입이 있는데 말 그대로 어떤 타입이든 들어올 수 있습니다. 하지만 이 타입을 사용하게 되면 어떤 타입이 들어올지 모르기 때문에 매번 런타임에 확인해야한다는 단점이있다. 따라서 CalculateItem을 채택한 타입만 들어올 수 있도록 제약사항이 필요한것이다.
- [연산프로퍼티를 사용하는 기준](https://www.swiftbysundell.com/tips/computed-properties-vs-methods/)
- Mutating
- Final키워들를 붙여줌으로써의 이점
코드를 읽을는 입장에서 상속이 없는 코드이구나라는 전제로 읽을 수 있어 가독성이 좋아진다.
그리고 final을 붙였을때 하위클래스의 최종 메서드, 속성 또는 하위 스크립트를 재정의하려는 모든 시도는 컴파일 시간오류로 보고가 되기때문에 final을 붙임으로써 컴파일 시간을 줄일 수 있어 성능에 도움이된다는 이유도 있다.[공식문서](https://docs.swift.org/swift-book/LanguageGuide/Inheritance.html#:~:text=%ED%81%B4%EB%9E%98%EC%8A%A4%20%EC%A0%95%EC%9D%98(%20)%EC%97%90%EC%84%9C%20%ED%82%A4%EC%9B%8C%EB%93%9C%20final%EC%95%9E%EC%97%90%20%EC%88%98%EC%A0%95%EC%9E%90%EB%A5%BC%20%EC%9E%91%EC%84%B1%ED%95%98%EC%97%AC%20%EC%A0%84%EC%B2%B4%20%ED%81%B4%EB%9E%98%EC%8A%A4%EB%A5%BC%20final%EB%A1%9C%20%ED%91%9C%EC%8B%9C%ED%95%A0%20%EC%88%98%20%EC%9E%88%EC%8A%B5%EB%8B%88%EB%8B%A4%20.%20%EC%B5%9C%EC%A2%85%20%ED%81%B4%EB%9E%98%EC%8A%A4%EB%A5%BC%20%ED%95%98%EC%9C%84%20%ED%81%B4%EB%9E%98%EC%8A%A4%EB%A1%9C%20%EB%A7%8C%EB%93%A4%EB%A0%A4%EB%8A%94%20%EB%AA%A8%EB%93%A0%20%EC%8B%9C%EB%8F%84%EB%8A%94%20%EC%BB%B4%ED%8C%8C%EC%9D%BC%20%EC%8B%9C%EA%B0%84%20%EC%98%A4%EB%A5%98%EB%A1%9C%20%EB%B3%B4%EA%B3%A0%EB%90%A9%EB%8B%88%EB%8B%A4.classfinal%20class)
- 사용하지않는 주석은 삭제한다.
- 테스트코드작성할떄 강제언랩핑을 하는이유 ?
테스트할때 수월하게 하기 위함입니다.
강제옵셔널이아닌 기본옵셔널 ? 표시도 가능했으나 이럴 경우에는 값을 사용할때마다 옵셔널로 맞춰서 비교해주거나 옵셔널을 벗겨서 값을 꺼내와야한다는 점이있고
기능을 테스트하기위해 값이 있다는 전제하에 하기때문에 어느정도 생략할 수 있고 만일 런타임이 발생하면 로직을 수정해줄 수 도 있다는 점이 있다.
- setUpWithError와 tearDownWithError메서드의 역할
setUpWithError메서드는 test case가 실행되기 전마다 호출되어 각 테스트가 모두 같은 상태와 조건에서 실행할 수 있게해주고
tearDownWithError메서드는 test실행이 끝난 후 마다 호출되는 메서드이며 setUpWithError에서 설정한 값들을 해제할때 사용합니다.
- 외부에서 프로퍼티를 보여줄 필요가없으면 private을 하고 되도록이면 외부에서는 프로퍼티에 값에 접근할 순있되 설정은 못하게끔 설계하는것이 안전합니다.

- 1급객체로 보이기때문과 (타입과 반환타입) 이 같아서 가능하다
```swift
let numbers: [Int] = [1, 2, 3]    
    numbers.forEach(sut.append(data:))
```
 
## 리뷰어 조언(@울라프)
- 속도는 중요하지않다. 어떠한 이유로 코드를 작성했고 그 이유가 얼마나 설득력이있는지가 나중에 면접해서 할얘기가 있는지 없는지를 만들어준다. 울라프도 부트캠프를 했었는데 허송세월을 보낸것같다고 얘기를 해주셨다. 왜냐하면 코드작성하는데에만 급급했기때문이다. 그런데 나보다 느렸지만 공부하면서 이유를 찾던 사람은 면접때 할 얘기가 많아서 오히려 그런사람들이 더 빨리 취업을 했다. 그러니 공부하는것이 가장 핵심적인 포인트라서 속도에 스트레스받을 필요가 없다는것이다.

# 학습키워드
- @testable
- final
- setUpWithError, tearDownWithError
- !
- private(set)
- LinkedList, Queue
- computed Property
- divide file
- Generic
- Protocol

# 공부해야할 키워드
- mutating
- 1급객체
- 큐의 특징

# 참고했던 블로그
처음에 참고했던 code [슈프림](https://tngusmiso.tistory.com/20)
이후에 참고한 code [개발자 소들이](https://babbab2.tistory.com/86?category=908011)
https://velog.io/@nnnyeong/%EC%9E%90%EB%A3%8C%EA%B5%AC%EC%A1%B0-%EC%8A%A4%ED%83%9D-Stack-%ED%81%90-Queue-%EB%8D%B1-Deque#%ED%81%90-queue


# STEP2 PR 받으면서 배우거나 학습한 내용
## 부동소수점이 발생하는 이유
### 부동소수점(Floating-Point Numbers)이란 ?
- 부동소수점이란 위와같이 3.14159, 0.1, and -273.15와 같은 소수구성요소가 있는 숫자를 말한다.

- 부동 소수점 유형은 정수유형보다 훨씬 더 넓은 범위의 값을 나타낼 수 있으며 Int에 저장할 수 있는 것보다 훨 씬 크거나 작은 숫자를 저장할 수 있다. Swift는 두가지 부호 있는 부동 소수점 숫자 유형을 제공한다.

- Double은 64비트 부동 소수점 숫자를 나타내고 Float은 32비트 부동 소수점 숫자를 나타낸다.

- Double의 정밀도는 최소 15자리 소수점 이하 자릿수인 반면 Float의 정밀도는 소수점 이하 6자리까지 가능하다. 사용할 적절한 부동 소수점 유형은 코드에서 작업해야하는 값의 특성과 범위에 따라 다르다. 두 유형 중 하나가 적절한 상황에서는 Double이 선호된다.

### 부동소수점이 발생하는 이유
```swift
let sum: Double = 0.1+0.2
print(sum)
// result '0.30000000000000004'
```
- 내부적으로 컴퓨터는 0.1, 0.2 또는 0.3과 같은 숫자를 정확하게 나타낼 수 없는 형식(이진 부동 소수점)을 사용하기 때문이다.
코드가 컴파일되거나 해석될때 “0.1”은 이미 해당형식에서 가장 가까운 숫자로 반올림되어 계산이 발생하기전에도 작은 반올림 오류가 발생한다.

### 왜 부동소수점이 필요할까 ?
- 컴퓨터 메모리는 제한되어 있기때문에 이진 분수를 사용하든 소수를 사용하든 상관없이 무한정 정밀도로 숫자를 저장할 수 없다. 그렇기때문에 어느 지점에서 끊어줘야한다.
그러나
얼마나 많은 정확도가 필요한것일까??
그리고 어디에서 필요할까??
정수의 자릿수와 분수의 자릿수는 몇개인가??

- 고속도로를 건설하는 엔지니어에게 너비가 10미터인지 10.0001미터인지는 중요하지않다.
- 마이크로칩을 설계하는 사람에게 0.0001미터(10분의 11밀리미터)는 엄청난 차이이다. 하지만 0.1미터보다 큰거리를 다룰 필요는 없을 것이다.
- 물리학자는 같은 계산에서 빛의 속도(약 300000000)와 뉴턴의 중력상수를 함께 사용해야한다.

엔지니어와 칩설계자를 만족시키기위해 숫자 형식은 매우 다른 크기의 숫자에 대한 정확도를 제공해야한다.
그러나 상대적 정확도만 필요하다. 물리학자를 만족시키려면 크기가 다른 숫자를 포함하는 계산을 수행할 수 있어야한다.
기본적으로 고정된 수의 정수 및 소수 자릿수를 갖는 것은 유용하지않으며 솔루션은 부동소수점 형식이다.

### 컴퓨터는 왜 이런시스템을 사용하는걸까 ?
10진수는 1/3과같은 숫자를 정확하게 나타낼수 없으므로 0.33과 같은 값으로 반올림해야 한다. 컴퓨터는 이진수를 처리하는 것이 더 빠르기때문에 이진수를 사용하고 대부분의 계산에서 소수점 이하 17자리의 작은 오류는 전혀 중요하지 않다.

### 반올림 오류
부동 소수점 숫자는 자릿수가 제한되어 있기때문에 모든 실수를 정확하게 나타낼 수 없다. 형식이 허용하는 것보다 더 많은 자릿수가 있는 경우 남은 자릿수는 생략되고 숫자는 반올림된다.

### 반올림이 필요한 이유는 크게 세가지가 있다.
- 유효 숫자가 너무 많을때
부동 소수점의 가장 큰 장점은 선행 및 후행 0(지수가 제공하는 범위 내)을 저장할 필요가 없다는 것이다. 그러나 그것들 없이 유효 숫자가 저장할 수 있는 것보다 더 많은 숫자가 있으면 반올림이 필요하다. 다시 말해서, 숫자가 단순히 형식이 제공할 수 있는 것보다 더 높은 정밀도를 요구한다면 그 중 일부를 희생해야한다.

- 주기적 자릿수
분모가 밑수에서 발생하지 않는 소인수를 갖는 모든 분수는 특정 지점 이후에 주기적으로 반복되는 무한한 수의 자릿수를 필요로 하며 이는 매우 단순한 분수에 대해 이미 발생할 수 있다. 예를 들어, 십진법 1/4에서 2와 5는 10의 소인수이기 때문에 3/5와 8/20은 유한합니다. 그러나 1/3은 유한하지 않으며 2/3, 1/7 또는 5/도 아닙니다. 6, 3과 7은 10의 약수가 아니기 때문입니다. 분모에서 소인수가 5인 분수는 10진법에서는 유한할 수 있지만 2진법에서는 유한하지 않을 수 있습니다.

- 비합리적 숫자
비합리적 숫자는 일반 분수로 전혀 나타낼 수 없으며 위치 표기법(기수에 관계 없이)에서는 무한한 숫자의 비반복 자릿수가 필요하다.
0.1 + 0.4와 같은 다른 계산이 올바르게 작동하는 이유는 무엇인가요 ?
이 경우 결과(0.5)는 부동소수점 숫자로 정확히 표시될 수 있으며 입력 숫자의 반올림 오류가 서로를 상쇄할 수 있다.

### 이문제를 방지하려면 어떻게 해야하나요 ?
어떤 종류의 계산을 하느냐에 따라 다르다.

- 특히 돈으로 작업할 때 결과를 정확히 합산해야하는 경우: 특수 10진수 데이터 유형을 사용하는 것이 좋다.
- 추가 소수자릿수를 모두 표시하지않으려면 결과를 표시할때 고정된 소수 자릿수로 반올림한 결과 형식을 지정하면 된다.
- 사용할 수 있는 10진수 데이터 유형이 없는 경우 대안은 정수로 작업하는 것이다. 그러나 이것은 더많은 작업이 필요하고 몇가지 단점이 존재한다.

### Reference
- [Floating-Point-Guide](https://floating-point-gui.de/formats/fp/)
- [stackoverflow](https://stackoverflow.com/questions/54626597/float-and-double-arithmetic-not-returning-accurate-results)
- [floating-pointNumber공식문서](https://docs.swift.org/swift-book/LanguageGuide/TheBasics.html#:~:text=Floating%2DPoint%20Numbers,Double%20is%20preferred.)

## ExpressionParser가 enum으로 구현된 이유
- 메모리에 계속 살아있는 네임스페이스를 사용하기 위함이다. struct나 class의 인스턴스메소드로 선언해주고 매번 인스턴스를 만들어 사용하는 방법도 있으나 앱 전역적으로 살아있어야하기때문이라면 매번 생성할 필요없이 enum을 만들어주는 편이다. (울라프 조언)

## STEP2 PR하면서 얻은 내용
- Author는 나중에 코드에 궁금증이나 이상이생겼을떄 만든사람에게 여쭤볼 수 있으니 그대로 두는게 좋다.
- override메서드는 super를 호출하는게 원칙중 하나이다. 꼭 불러줘야한다.
- TDD를 작성할때는 User가 어떻게 입력할지 ? 생각하면서 엣지케이스를 작성하는게 좋다.
- 메소드를 동사형으로 사용할떄는 사이드이펙이 발생하는 코드를 뜻하고 메서드가 과거분사이면 사이드이펙이없고 연산프로퍼티는 사이드이펙이없이 단순 값을 반환하는 역할로 사용 될 수 있다. (https://www.swiftbysundell.com/tips/computed-properties-vs-methods/)
- 이모지로 연산자를 사용하는 방법이 구분되고 잘 사용하는 방법일 수 있지만 나중에 어떠한 사이드이펙을 발생시킬지는 의문일 수 있어 가능하다면 수정하는게 좋을 것같다.
- 아래와 같이 로직을 직접 그려보는게 이해하는데 굉장히 도움이 많이되서 code practing은 이해가안될때나 설명할때 사용하면 좋습니다.
```swift
예시) 5➕10➖5➗2 ✖️3➕5
operands = 5,10,5,2,3,5
operators = ➕, ➖, ➗, ✖️, ➕
var operandsCount = 6

첫번째 반복문, 2...6
var result = operands.dequeue //5
var operandValue = operands.dequeue //10
var operatorValue  = operators.dequeue //➕
result = operatorValue.calculate(5➕10)

두번째 반복문, 3...6
operands = 5,2,3,5
operators = ➖,➗,✖️,➕

var result = 15
var operandValue = operands.dequeue //5
var operatorValue  = operators.dequeue //➖
result = operatorValue.calculate(15➖5)

세번째 반복문, 4...6
operands = 2,3,5
operators = ➗,✖️,➕

var result = 10
var operandValue = operands.dequeue //2
var operatorValue  = operators.dequeue //➗
result = operatorValue.calculate(10➗2)

네번째 반복문, 5...6
operands = 3,5
operators = ✖️,➕

var result = 5
var operandValue = operands.dequeue //3
var operatorValue  = operators.dequeue //✖️
result = operatorValue.calculate(5✖️3)


다섯번째 반복문, 6...6
operands = 5
operators = ➕

var result = 15
var operandValue = operands.dequeue //5
var operatorValue  = operators.dequeue //➕
result = operatorValue.calculate(15➕5)

return result //20
```
- flatMap은 디플리케이티드 예정인게 있어서 잘 참고하고 사용하는게 좋고 혹여나 디플리케이티드가 되있는 코드는 언제 삭제해도 이상하지않다는걸 애플이 공지한거라서 나중에 디플리케이티드된 메서드가 삭제되면 빌드자체가 안되기때문에 지양해야한다.


## STEP3 및 코드합치는 팀프로젝트하면서 느낌점, 공부한것, 배운것, 피드백받은것, 문제해결 등

## 리뷰어가 피드백 해주신 내용
- MVVM을 사용하는게 뷰컨이 비대해진닥는 이유는 너무 부수적인것중에 하나이며 지금은 알필요없다.
- 뷰는 이벤트전달과 보여주는것만하지 에러를 잡아 던지는건 옳지않다.
- 조건문이 길경우 상황이 어떤상황인지 알기가어렵다. 이러한 경우에는 연산프로퍼티나 메서드로 네이미을 잡아주는게 좋음
```swift=
    private var isCalculated: Bool { !allCalculatStack.isEmpty && operatorLabel.text?.isEmpty == true }
    private var isDotContained: Bool { operandLabel.text?.contains(String.dot) == true }
    private var isInitialState: Bool { operandLabel.text == .zero && allCalculatStack.isEmpty }
    private var isErrorHappened: Bool {
```
- 매개변수로 버튼이나 네이블타입을 받기보다 . Text 같은 스콥을 줄여주는 매개변수가 더 좋음
- stackView설정시 Axis = .horizontal, alignment = .fill, distribution = .fill 이렇게 기본값이기때문에 따로 설정해줄 필요가 없다. 다른 뷰를만들때도 유사한 기본값들이 존재하니 잘확인해보자.
- 사이드 이펙트가 발생하지않는 메서드는 동사원형으로 네이밍을 작성해야할것

*질문사항에대한 답변)*
- is 네이밍도 불에대해서 메서드명이로 사용될수있는지 => 대부분은 연산프로퍼티에 is를 사용함
- isOperatorAtFirstElement vs isFirstElementAtOperator  # 보충
- Model, view, VC의 역할을 구분하자


## 알게된점
- extension앞에 private을 사용하게되면 변수 및 메서드에 각각 private을 붙일 필요가 없다.
- 익스텐션으로 String? 타입에 코드를 추가할때는 String extension으로 추가하는것이아니라 옵셔널 익스텐션으로 추가해야한다. 왜냐하면 String?과 String은 아예다른 타입이기때문이다.
```swift
extension Optional where Wrapped == String {
    var unwrapped: String {
        guard let result = self else { return CalculatorConstant.blank }
        return result
    }
}
```

- 스크롤뷰를 사용할때
로컬라이즈드 에러를 사용하고 다운케스트를 하게되면 

## 문제해결
- StackView내에 label이 담긴 StackView를 추가하고 label의 값을 추출해야하는 상황이 발생할때 값을 어떻게 꺼내서 사용할것인가?
1. 첫번째 방법은 전역변수를 두고 상위 StackView에 label을 추가할때 계산식을 전역변수에동시에 값을 저장하여 사용한다.
2. 상위 stackView의 arrangedSubViews를 접근하여 다운캐스트를 시도하여 값을 추출한다.

개인적인 생각으로 후자가 사이드이펙트가 없으며 코드가 깔끔해지고 불필요한 변수를 생성할 필요또한 없다고 판단하여 후자코드가 더 좋아보인다.

```swift=
        calculateStacks.arrangedSubviews.forEach {
            let subStackView = $0 as? UIStackView
            let operatorLabel = subStackView?.arrangedSubviews.first as? UILabel
            let operandLabel = subStackView?.arrangedSubviews.last as? UILabel
    }
```
그리고 여기서 값을 remove하여 접근할 수 있는가 시도를 해봤으나 arrangedSubviews는 [UIView] {get}으로 읽기전용이다. 그래서
안전하게 다운캐스트로 접근하는 방법을 사용했다.

# layoutIfNeeded, setNeedsLayout, setNeedsDisplay의 차이는 무엇인가? 
- layoutIfNeeded
함수의 main loop가 끝나야만 update cycle이 샐행되어 뷰의 업데이트가 적용되이 된다. 그런데 스크롤뷰를 사용할때 스크롤 아래로 내려주는 작업이 진행된 후 update cycle에서
뷰가 추가되었기때문에 맨 아래 뷰가 숨겨지는 문제가 발생했다. 이런 문제를 해결해주기위해 사용하는 메서드가 layoutIfNeeded이며 이는 호출된 시점에 즉시 뷰를 바로 업데이트해주는 역할을 한다.

- setNeedsLayout
이 메서드는 layoutIfNeeded메서드와 다르게 비동기적으로 동작합니다. 그래서 바로 View가 업데이트되지않고 View업데이트를 예약함으로써 다음 Main Run Loop가 끝난 후에 Update Cycle에서 작동합니다.

- setNeedDisPlay()
수신기의 전체 경계 사각형을 다시 그려야하는 것으로 표시한다...(공부필요)

# 앱 bounds와 frame의 개념 및 차이점
- superView란 최상위 view인 루트 View가 아니라 나의 한칸 윗계층의 View를 말하는것
- frame은 superView를 기준으로 본인의 위치(0,0)을 잡는다.
- frame은 size는 view의 자체 크기를 말하는것이아니라 view가 차지하는 영역을 감싸서 만든 사각형을 말한다. 그래서 view가 회전할때 값이 바뀐다.
- bounds는 self view를 기준으로 위치(0,0)를 잡는다.

 ### frame및 bounds의 사용처
 ### [frame]
 - View의 크기를 확인할때 사용함
 
 ### [bounds]
 - View를 회전한 후 View의 실제크기를 알고 싶을때사용한다. 왜냐하면 frame의 origin및 size와 bounds의 origin 및 size는 다르기떄문이다.
 - View내부에 그림을 그릴때(drawRect)사용한다.
 - ScrollView에서 크르롤을 할때 사용한다.


참고자료
- [소들이블로그](https://babbab2.tistory.com/46)

## viewDidLoad가 불리는 시점 복습

- 초기에 앱을 실행하고 init이 된 이후에 viewDidLoad가 불리기도하고 화면전환이될때 그 뷰에대한 로드가된 시점에 불리는것으로 이해하고 있습니다.

## viewDidLoad의 특징

- ViewController의 모든뷰들이 메모리에 로드되었을때 호출됩니다. ex) IBOutltet변수들
- 생명주기에서 첫뷰에대한 viewDidLoad는 딱 한번 불립니다. 그래서 한번호출될 필요가 있는 메서드를 안에서 실행해줄 수 있습니다.

## 주간 학습키워드
- ARC
- weak, unowned
- 메모리구조
- AppDelegate
- SceneDelegate
- iOS App Life Cycle
- viewDidLoad
- Closure variable create method


## 공부해야할것
- weak로 강한참조가 되는 동작원리 DuDu블로그 참고(https://velog.io/@aurora_97/TIL-Delegate%EC%99%80-Weak)
- flag란?
- ScrollView사용할때 View의 크기와 ScrollView의 크기를 빼서 사용하는 계산법 이해하기
- NumberFormatter
- IBOutlet을 사용할때 강제언랩핑을 사용하는 이유
- AppDelegate와 SceneDelegate에대한 WWDC 2019영상 시청


# 계산기 프로젝트 코드 합치면서 느낀점
- 코드의 함수기능분리가 다소 아쉬웠어서 나의 코드의 부족함을 많이느꼈다.
- 코드를 합칠때 적절하게 한명한명의 코드에 잘한이점을 보려고 노력하며 그 점을 중심으로 합치려고 노력했다.
- 코드에는 정답이없다보니 코드를 합치는 기준을 선정하는게 더욱 어려웠다. 그리고 처음에는 내가 작성했던 코드들이 사용되지못했다는 아쉬움과 속상함이 들수있으나 잘하는 사람에게 코드를 배울 수 있으며 이성적으로 회사에 다닌다고 생각하니 받아들이는게 더 가벼워진 기분이었다. 그래서 다수의 의견을 따르는데에 있어서 나의 코드의 부족한점을 인정하고 받아들이는 연습을 할 수 있었던것같다. 최종적으로 직관적으로 네이밍이 좋고 코드가 깔끔하다고 판단되는 코드를 최대한 선택하였다.
