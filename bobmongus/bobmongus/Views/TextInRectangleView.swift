//
//  TextInRectangleView.swift
//  bobmongus
//
//  Created by Hyeonsoo Kim on 2022/04/12.
//

import SwiftUI

struct TextInRectangleView: View {
    var body: some View {
        ScrollView {
            Text("""
제1조(목적) 이 약관은 업체 회사가 운영하는 앱(이하 “앱”이라 한다)에서 제공하는 서비스를 이용함에 있어 이용자의 권리․의무 및 책임사항을 규정함을 목적으로 합니다.
 
제2조(정의)
 
  ① “앱”이란 업체 회사가 재화 또는 용역(이하 “재화 등”이라 함)을 이용자에게 제공하기 위하여 컴퓨터 등 정보통신설비를 이용하여 재화 등을 거래할 수 있도록 설정한 가상의 영업장을 말하며, 아울러 사이버몰을 운영하는 사업자의 의미로도 사용합니다.
 
  ② “이용자”란 “앱”에 접속하여 이 약관에 따라 “앱”이 제공하는 서비스를 받는 회원 및 비회원을 말합니다.
 
  ③ ‘회원’이라 함은 “앱”에 회원등록을 한 자로서, 계속적으로 “앱”이 제공하는 서비스를 이용할 수 있는 자를 말합니다.
 
  ④ ‘비회원’이라 함은 회원에 가입하지 않고 “앱”이 제공하는 서비스를 이용하는 자를 말합니다.
 
제3조 (약관 등의 명시와 설명 및 개정)
 
  ① “앱”은 이 약관의 내용과 상호 및 대표자 성명, 영업소 소재지 주소(소비자의 불만을 처리할 수 있는 곳의 주소를 포함), 전화번호․모사전송번호․전자우편주소, 사업자등록번호, 통신판매업 신고번호, 개인정보관리책임자 등을 이용자가 쉽게 알 수 있도록 00 사이버몰의 초기 서비스화면(전면)에 게시합니다. 다만, 약관의 내용은 이용자가 연결화면을 통하여 볼 수 있도록 할 수 있습니다.
 
  ② “앱은 이용자가 약관에 동의하기에 앞서 약관에 정하여져 있는 내용 중 청약철회․배송책임․환불조건 등과 같은 중요한 내용을 이용자가 이해할 수 있도록 별도의 연결화면 또는 팝업화면 등을 제공하여 이용자의 확인을 구하여야 합니다.
 
  ③ “앱”은 「전자상거래 등에서의 소비자보호에 관한 법률」, 「약관의 규제에 관한 법률」, 「전자문서 및 전자거래기본법」, 「전자금융거래법」, 「전자서명법」, 「정보통신망 이용촉진 및 정보보호 등에 관한 법률」, 「방문판매 등에 관한 법률」, 「소비자기본법」 등 관련 법을 위배하지 않는 범위에서 이 약관을 개정할 수 있습니다.
 
  ④ “앱”이 약관을 개정할 경우에는 적용일자 및 개정사유를 명시하여 현행약관과 함께 몰의 초기화면에 그 적용일자 7일 이전부터 적용일자 전일까지 공지합니다. 다만, 이용자에게 불리하게 약관내용을 변경하는 경우에는 최소한 30일 이상의 사전 유예기간을 두고 공지합니다.  이 경우 "앱“은 개정 전 내용과 개정 후 내용을 명확하게 비교하여 이용자가 알기 쉽도록 표시합니다.
 
  ⑤ “앱”이 약관을 개정할 경우에는 그 개정약관은 그 적용일자 이후에 체결되는 계약에만 적용되고 그 이전에 이미 체결된 계약에 대해서는 개정 전의 약관조항이 그대로 적용됩니다. 다만 이미 계약을 체결한 이용자가 개정약관 조항의 적용을 받기를 원하는 뜻을 제3항에 의한 개정약관의 공지기간 내에 “앱”에 송신하여 “앱”의 동의를 받은 경우에는 개정약관 조항이 적용됩니다.
 
  ⑥ 이 약관에서 정하지 아니한 사항과 이 약관의 해석에 관하여는 전자상거래 등에서의 소비자보호에 관한 법률, 약관의 규제 등에 관한 법률, 공정거래위원회가 정하는 「전자상거래 등에서의 소비자 보호지침」 및 관계법령 또는 상관례에 따릅니다.
""")
        }
        .frame(width: 300, height: 159)
        .padding()
        .background(RoundedRectangle(cornerRadius: 6)
            .stroke(.gray, lineWidth: 0.5))
        .padding(.bottom, 5)
        
//        ZStack {
//            RoundedRectangle(cornerRadius: 8)
//                .stroke()
//                .frame(width: 300, height: 159)
//                .overlay(
//                    ScrollView {
//                        Text("""
//                I. 개인정보의 수집 및 이용 동의서
//                - 이용자가 제공한 모든 정보는 다음의 목적을 위해 활용하며,
//                하기 목적 이외의 용도로는 사용되지 않습니다.
//                ① 개인정보 수집 항목 및 수집·이용 목적
//                가) 수집 항목 (필수항목)
//                - 이메일, 사진, 주소
//                나) 수집 및 이용 목적
//                - 위치 정보 확인
//                ② 개인정보 보유 및 이용기간
//                - 수집·이용 동의일로부터 개인정보의 수집·이용목적을 달성
//                """)
//                        .padding()
//                }
//            )
//        }
    }
    
    
}

struct TextRectangleView_Previews: PreviewProvider {
    static var previews: some View {
        TextInRectangleView()
            .environmentObject(ModelData())
    }
}
