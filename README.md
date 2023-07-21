# 은행창구 매니저</br>
> 은행에는 3명의 은행원이 근무하며 2명의 은행원은 예금업무를 담당하며, 1명의 은행원은 대출을 담당합니다.
> 은행에서 대출과 예금 업무를 할 수 있으며 은행원들이 이를 분담하여 업무를 진행합니다 </br>

## 📚 목차</br>
- [팀원소개](#-팀원-소개)
- [파일트리](#-파일트리)
- [타임라인](#-타임라인)
- [실행화면](#-실행화면)
- [트러블 슈팅](#-트러블-슈팅)
- [참고자료](#-참고자료)

## 🧑‍💻 팀원 소개</br>
| <img src="https://user-images.githubusercontent.com/101572902/235090676-acefc28d-a358-486b-b9a6-f9c84c52ae9c.jpeg" width="200" height="200"/> | <img src="https://github.com/devKobe24/BranchTest/blob/main/IMG_5424.JPG?raw=true" width="200" height="200"/> |
| :-: | :-: |
| [**Hamg**](https://github.com/hemg2) | [**Kobe**](https://github.com/devKobe24) |

## 🗂️ 파일트리</br>
```
.
├── BankManagerConsoleApp
│   ├── BankManager
│   │   ├── BankManager.swift
│   │   ├── BankService.swift
│   │   ├── Banker.swift
│   │   ├── Customer.swift
│   │   ├── CustomerQueue.swift
│   │   └── Model
│   │       ├── BankingServiceTimeConverter.swift
│   │       ├── Enum
│   │       │   ├── BankManagerNameSpace.swift
│   │       │   └── BankingOperations.swift
│   │       └── TimeCheck.swift
│   ├── DataStructure
│   │   ├── LinkedList.swift
│   │   ├── Node.swift
│   │   └── Queue.swift
│   ├── Error
│   │   ├── InputError.swift
│   │   └── NumberFormatError.swift
│   └── main.swift
├── BankManagerConsoleApp.xcodeproj
│   ├── project.pbxproj
│   ├── project.xcworkspace
│   │   ├── contents.xcworkspacedata
│   │   ├── xcshareddata
│   │   │   ├── IDEWorkspaceChecks.plist
│   │   │   └── swiftpm
│   │   │       └── configuration
│   │   └── xcuserdata
│   │       └── mskang.xcuserdatad
│   │           └── UserInterfaceState.xcuserstate
│   ├── xcshareddata
│   │   └── xcschemes
│   │       ├── BankManagerConsoleApp.xcscheme
│   │       └── BankMangerQueueTests.xcscheme
│   └── xcuserdata
│       └── mskang.xcuserdatad
│           ├── xcdebugger
│           │   └── Breakpoints_v2.xcbkptlist
│           └── xcschemes
│               └── xcschememanagement.plist
└── BankMangerQueueTests
    ├── BankMangerQueueTests.swift
    └── TestPlan.xctestplan
```

## ⏰ 타임라인</br>
프로젝트 진행 기간 | 23.07.10.(월) ~ 23.07.14.(금)

| 날짜 | 진행 사항 |
| -------- | -------- |
| 23.07.10.(월)     | Node 생성<br/> LinkedList 생성.<br/> final 접근제한자 추가.<br/> |
| 23.07.11.(화)     | LinkedList 구현 진행, Type->T 변경<br/> Queue 타입 구현 및 생성.<br/> BankManagerTests 생성 및 구현<br/>|
| 23.07.12.(수)     | testCase추가, Linked-> count,insert 추가|
| 23.07.14.(금)     | Customer 타입 생성 및 구현.<br/>Banker 타입 생성 및 구현<br/>TimeCheck 메서드 생성 및 구현.<br/>InputError 타입 생성<br/>BankService 타입 생성 및 구현.<br/>    |
| 23.07.19.(수)     | CustomerQueue 타입 생성 및 구현.<br/>Banker 타입 생성 및 구현<br/> BankingOperations 열거형 생성 및 구현.<br/> bankingServiceTimeConverter, error 생성 및 구현<br/> OperationQueue추가, bankingServiceTask 메서드 구현 nameSpace추가구현<br/>    |
| 23.07.20.(목)     | BankService 객체내의 메서드 로직 수정 및 추가  |

## 📺 실행화면
- JuiceMaker 실행 화면 </br>
![](https://cdn.discordapp.com/attachments/767712487625719810/1131742446309613658/41c3490ff7926075.gif)

## 🔨 트러블 슈팅 
1️⃣ **대출,예금 업무 분리** </br>
🔒 **문제점** </br>
대출과 예금이 업무가 분리되어 있었습니다.
또한 대출은 1.1초 예금은 0.7초의 업무 시간이 분배되어 있었습니다.
그래서 어떻게하면 업무를 분리하여 처리할 수 있을까 고민을 많이 했습니다.


🔑 **해결방법** </br>
enum으로 타입을 만들고 CaseIterable 프로토콜을 채택하여 나중에 `allCases.randomElement()`를 사용할 수 있도록 했습니다.
또한 enum 내부에서 case 별로 대출과 예금을 나누어 주었습니다.
그래서 다음과 같은 코드를 작성하게 되었습니다.

```swift!
enum BankingOperations: CaseIterable {
	case deposit
	case loan
	
	var duration: Double {
		switch self {
		case .deposit:
			return 0.7
		case .loan:
			return 1.1
		}
	}
	
	var financialProductsName: String {
		switch self {
		case .deposit:
			return "예금"
		case .loan:
			return "대출"
		}
	}
}
```

2️⃣ **스레드의 분배**</br>
🔒 **문제점 2** </br>
예금 업무는 2명의 은행원이 담당해야하고 대출 업무는 1명의 은행원이 담당해야 한다는 스탭 제약 사항이 있었습니다.
그래서 어떻게 은행원을 2명과 1명으로 나누어야 할지 고민이 많았습니다.

🔑 **해결방법** </br>
먼저 `OperationQueue`를 각각 `예금 은행원 큐`, `대출 은행원 큐`를 만들어 주었습니다.
각각의 `예금 은행원 큐`와 `대출 은행원 큐`를 2명과 1명으로 나누어야 하기 때문에 `maxConcurrentOperationCount`를 사용하여 `예금 은행원 큐`는 `2`를 할당, `대출 은행원 큐`는 `1`을 할당해주어 2명과 1명으로 나누어 주었습니다.
그래서 다음과 같은 코드를 작성하게 되었습니다.

```swift!
depositBankerQueue.maxConcurrentOperationCount = 2
loanBankerQueue.maxConcurrentOperationCount = 1
```

## 📑 참고자료
- [📃 Date](https://developer.apple.com/documentation/foundation/date)</br>
- [📃 TimeInterval](https://developer.apple.com/documentation/foundation/timeinterval)</br>
- [📃 DateFormatter](https://developer.apple.com/documentation/foundation/dateformatter)</br>
- [📃 TimeZone](https://developer.apple.com/documentation/foundation/timezone)</br>
- [📃 Calendar](https://developer.apple.com/documentation/foundation/calendar)</br>
- [📃 DateComponents](https://developer.apple.com/documentation/foundation/datecomponents)</br>
- [📃 DispatchQueue의 init](https://developer.apple.com/documentation/dispatch/dispatchqueue/2300059-init)</br>
- [📃 DispatchQoS](https://developer.apple.com/documentation/dispatch/dispatchqos)</br>
- [📃 Prioritize Work with Quality of Service Classes](https://developer.apple.com/library/archive/documentation/Performance/Conceptual/EnergyGuide-iOS/PrioritizeWorkWithQoS.html#//apple_ref/doc/uid/TP40015243-CH39-SW1)</br>
- [📃 async](https://developer.apple.com/documentation/dispatch/dispatchqueue/2016098-async)</br>
- [📃 DispatchGroup](https://developer.apple.com/documentation/dispatch/dispatchgroup)</br>
- [📃 DispatchSemaphore](https://developer.apple.com/documentation/dispatch/dispatchsemaphore)</br>
