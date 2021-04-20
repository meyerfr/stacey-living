import React, { Component } from 'react'
import moment from 'moment'

import { Page, Image, Text, View, Document, StyleSheet, Font } from '@react-pdf/renderer';
import logo from '../../../assets/images/stacey_logo_schwarz.png'
import fontRegular from '../../../assets/stylesheets/fonts/Montserrat-Regular.ttf'
import fontBold from '../../../assets/stylesheets/fonts/Montserrat-Bold.ttf'
import mrDeHaviland from '../../../assets/stylesheets/fonts/MrDeHaviland-Regular.ttf'

// // Register font
Font.register({ family: 'Montserrat', fonts: [
  { src: fontRegular }, // font-style: normal, font-weight: normal
  { src: fontBold, fontStyle: 'bold' }
]});

Font.register({family: 'Mr De Haviland', src: mrDeHaviland})

// Create styles
const styles = StyleSheet.create({
  body: {
    paddingVertical: 30,
    paddingHorizontal: 35,
    fontSize: 11,
    fontFamily: 'Montserrat'
  },
  table: {
    width: '100%',
    borderStyle: "solid",
    borderWidth: 1,
    borderRight: 0,
    marginVertical: 5
  },
  notFullWidthTable: {
    width: '100%',
    marginVertical: 9,
    display: 'flex',
    alignItems: 'center',
    justifyContent: 'center'
  },
  tableRow: {
    display: 'flex',
    flexDirection: 'row',
    flexWrap: 'wrap',
    width: '100%',
    fontSize: 9,
  },
  notFullWidthTableRow: {
    display: 'flex',
    flexDirection: 'row',
    flexWrap: 'wrap',
    width: '60%',
    fontSize: 9,
    border: 1,
    borderRight: 0
  },
  tableCol: {
    display: 'flex',
    flexDirection: 'column',
    // borderStyle: "solid",
    borderRight: 1,
    // width: 'auto',
    alignItems: 'center',
    justifyContent: 'center',
    width: '15%',
    textAlign: 'center',
  },
  tableColLarge: {
    display: 'flex',
    flexDirection: 'column',
    // borderStyle: "solid",
    borderRight: 1,
    // width: 'auto',
    // alignItems: 'center',
    alignItems: 'center',
    justifyContent: 'center',
    width: '20%',
    textAlign: 'center',
  },
  tableHeader: {
    fontSize: 9,
    // borderStyle: "solid",
    // borderWidth: 1,
    borderBottom: 1,
    padding: '5px',
    width: '100%',
    fontStyle: 'bold'
  },
  tableCell: {
    padding: '5px',
    fontSize: 9,
    width: '100%',
  },
  tableColFullWidth: {
    fontSize: 9,
    borderStyle: "solid",
    // borderTop: 1,
    borderRight: 1,
    padding: 10,
    textAlign: 'center',
    // width: '100%'
  },
  documentHeader: {
    width: '100%',
    display: 'flex',
    flexDirection: 'column',
    justifyContent: 'center',
    alignItems: 'center',
    marginBottom: 10
  },
  imageContainer: {
    width: '100%',
    borderBottom: 1,
    paddingBottom: 7
  },
  image: {
    alignSelf: 'center',
    width: '160px'
  },
  margin: {
    marginBottom: '50px'
  },
  background: {
    backgroundColor: '#eaeaea',
  },
  centerElements: {
    display: 'flex',
    flexDirection: 'column',
    // alignItems: 'center',
    textAlign: 'center',
    borderRight: 1,
    width: '100%'
  },
  paragraph: {
    fontSize: 11,
    marginBottom: 8
  },
  bodyHeader: {
    fontSize: 13,
    fontStyle: 'bold',
    marginVertical: 12
  },
  sectionHeader: {
    fontSize: 16,
    fontStyle: 'bold',
    alignSelf: 'center',
    marginBottom: 10
  },
  section: {
    display: 'flex'
  },
  listItem: {
    // paddingLeft: 10,
    display: 'flex',
    flexDirection: 'row',
    marginBottom: 5,
    marginLeft: 5
  },
  listCount: {
    marginRight: 5
  },
  flex: {
    display: 'flex',
    flexDirection: 'row',
    fontSize: 11,
    marginVertical: 3
  },
  bold: {
    fontStyle: 'bold',
    marginLeft: 3
  },
  documentDate: {
    display: 'flex',
    flexDirection: 'column',
    marginBottom: 8,
    fontSize: 8
  },
  borderTop: {
    borderTop: 1
  },
  underline: {
    textDecoration: 'underline'
  },
  signContractWrapper: {
    width: '100%',
    display: 'flex',
    alignItems: 'center',
    justifyContent: 'center',
    marginTop: 5
  },
  signContractSection: {
    display: 'flex',
    flexDirection: 'row',
    alignItems: 'end',
    width: '60%',
    padding: 5,
    fontSize: 9,
    marginVertical: 7
  },
  signContractSectionInfo: {
    width: '30%'
  },
  inputField: {
    width: '70%',
    borderBottom: 1,
    padding: 3,
    display: 'flex',
    flexDirection: 'row',
    alignItems: 'center'
    // textAlign: 1
  },
  borderRight: {
    borderRight: 1
  },
  signature: {
    fontFamily: 'Mr De Haviland',
    fontSize: 15
  },
  signatureDate: {
    letterSpacing: 0,
    fontSize: 9,
    marginRight: 20
  }
});


class ContractPdfDocument extends Component {
  signContract = (contract, user) => {
    return(
      <View style={styles.signContractWrapper} wrap={false}>
        <View style={styles.signContractSection}>
          <Text style={styles.signContractSectionInfo}>Tenant Name</Text>
          <Text style={styles.inputField}>{`${user?.first_name} ${user?.last_name}`}</Text>
        </View>
        <View style={styles.signContractSection}>
          <View style={styles.signContractSectionInfo}>
            <Text>Date & Signature</Text>
            <Text style={styles.bold}>(tenant)</Text>
          </View>
          <View style={styles.inputField}>
            {
              contract.signature !== null ?
                [
                  <Text key="signedDate" style={styles.signatureDate}>
                    {moment(contract.signed_date).format('Do MMMM YYYY')},
                  </Text>,
                  <Text key="signature" style={styles.signature}>
                    {contract.signature}
                  </Text>
                ]
              :
                <Text>-</Text>
            }
          </View>
        </View>
        <View style={styles.signContractSection}>
          <View style={styles.signContractSectionInfo}>
            <Text>Date & Signature</Text>
            <Text style={styles.bold}>(lessor)</Text>
          </View>
          <View style={styles.inputField}>
            <Text style={styles.signatureDate}>
              {new Date().toISOString().slice(0, 10)},
            </Text>
            <Text style={styles.signature}>
              Matteo Kreidler
            </Text>
          </View>
        </View>
      </View>
    )
  }

  diff(d1, d2) {
    let diff = moment(d2).subtract(1, 'd').diff(moment(d1), 'months')
    return diff
  }

  findPrice = (moveIn, moveOut, prices) => {
    let date_diff = this.diff(moveIn, moveOut)
    let price = prices[2]
    switch(true) {
      case (date_diff < 5):
        price = prices[0]
        break;
      case (date_diff < 8):
        price = prices[1]
        break;
      default:
        price
    }
    return price;
  }

  render() {
    const booking = this.props.booking

    const moveIn = booking?.move_in
    const moveOut = booking?.move_out

    const contract = this.props.contract

    const user = booking?.user
    // let userAddress = user?.address
    const address = user?.address
    const userAddress = (user && address) ? `${user.address?.street}, ${user.address?.city} ${user.address?.zip}, ${user.address?.country}` : ''


    const project = this.props.project
    const projectAddress = `${project.address?.street}, ${project.address?.city} ${project.address?.zip}, ${project.address?.country}`

    const roomtype = this.props.roomtype
    const price = roomtype && this.findPrice(moveIn, moveOut, roomtype.prices)
    return(
      <Document style={{width: '100%', height: '100%'}}>
        <Page size="A4" style={styles.body} wrap>
          <View style={styles.documentHeader}>
            <View style={styles.imageContainer}>
              <Image
                style={styles.image}
                src={logo}
              />
            </View>
            <View style={styles.flex}>
              <Text>Rental Agreement between</Text>
              <Text style={styles.bold}>the lessor</Text>
            </View>
            <Text>STACEY Real Estate UG</Text>
            <Text>Brandstwiete 36</Text>
            <Text>20457 Hamburg</Text>
            <View style={styles.flex}>
              <Text>and</Text>
              <Text style={styles.bold}>the tenant</Text>
            </View>
            <Text>{`${user?.first_name} ${user?.last_name}`}</Text>
            {
              typeof user?.dob !== 'undefined' && user?.dob !== null &&
              <Text>Born {moment(user?.dob).format('Do MMMM YYYY')}</Text>
            }
            {
              userAddress !== '' &&
              <Text>{userAddress}</Text>
            }
          </View>
          <View style={styles.documentDate}>
            <Text>Date:</Text>
            <Text>{moment(contract.signed_date).format('Do MMMM YYYY')}</Text>
          </View>
          <View style={styles.table}>
            {/* TableHeader */}
            <View style={styles.tableRow}>
              <View style={styles.tableCol}>
                <Text style={[styles.tableHeader, styles.background]}>Description</Text>
              </View>
              <View style={styles.tableColLarge}>
                <Text style={[styles.tableHeader, styles.background]}>Property Address</Text>
              </View>
              <View style={styles.tableCol}>
                <Text style={[styles.tableHeader, styles.background]}>Room</Text>
              </View>
              <View style={styles.tableColLarge}>
                <Text style={[styles.tableHeader, styles.background]}>Monthly Price</Text>
              </View>
              <View style={styles.tableCol}>
                <Text style={[styles.tableHeader, styles.background]}>Start Date</Text>
              </View>
              <View style={styles.tableCol}>
                <Text style={[styles.tableHeader, styles.background]}>End Date</Text>
              </View>
            </View>
            <View style={styles.tableRow}>
              <View style={styles.tableCol}>
                <Text style={styles.tableCell}>STACEY Rent</Text>
              </View>
              <View style={styles.tableColLarge}>
                <Text style={styles.tableCell}>{projectAddress}</Text>
              </View>
              <View style={styles.tableCol}>
                <Text style={styles.tableCell}>{roomtype?.name}</Text>
              </View>
              <View style={styles.tableColLarge}>
                <Text style={styles.tableCell}>{price.amount} €</Text>
              </View>
              <View style={styles.tableCol}>
                <Text style={styles.tableCell}>{moment(moveIn).format('DD/MM/YYYY')}</Text>
              </View>
              <View style={styles.tableCol}>
                <Text style={styles.tableCell}>{moment(moveOut).format('DD/MM/YYYY')}</Text>
              </View>
            </View>
          </View>
          <View style={styles.table}>
            <View style={styles.tableRow}>
              <Text style={[styles.background, styles.tableColFullWidth, styles.tableHeader]}>Terms of Service</Text>
              <Text style={styles.tableColFullWidth}>Payment terms: monthly; due on the {moment(moveIn).format('DD/MM/YYYY')} for the first (partial) calendar month, and due the 1st day, at leatest by the 3rd business day of each calendar month for the following months. Deposit in form of 2-months rent is due upon signing the agreement.</Text>
            </View>
          </View>
          <View style={styles.table}>
            <View style={styles.tableRow}>
              <Text style={styles.tableColFullWidth}>This is the rental contract for your STACEY room. By signing, you acknowledge that you have read, understood and agree to the (1) Rental Agreement, (2) Terms and Condition of Internet Use, (3) House Rules. Any other terms and conditions do not apply to this contract and are null and void.</Text>
            </View>
          </View>
          <View style={styles.table}>
            <View style={styles.tableRow}>
              <Text style={styles.tableColFullWidth}>If we do not receive a document stating the confirmation of the transaction of your security deposit within 48h after signing your agreement, your rental agreement will be canceled.</Text>
            </View>
          </View>
          <View style={styles.notFullWidthTable}>
            <View style={styles.notFullWidthTableRow}>
              <Text style={[styles.background, styles.tableColFullWidth, styles.tableHeader]}>Payment Information</Text>
              <View style={[styles.centerElements, styles.tableColFullWidth]}>
                <Text>Your monthly rent will be paid to the following account:</Text>
                <Text>STACEY Real Estate UG</Text>
                <Text>IBAN: DE61 2005 0550 1500 8679 06</Text>
                <Text>BIC: HASPDEHHXXX</Text>
              </View>
            </View>
          </View>
          {
            this.signContract(contract, user)
          }
          <View style={styles.section}>
            <Text style={styles.sectionHeader} break>(1) Rental Contract</Text>
            <View style={styles.sectionBody} wrap={false}>
              <Text style={styles.bodyHeader}>1. Subject Matter of the Agreement</Text>
              <Text style={styles.paragraph}>STACEY rents out only furnished rooms of the shared apartments. The rooms of shared apartments operated by STACEY are rented out to each member as private rooms. The apartments are rented to the STACEY member for exclusive use as living space. The STACEY member shall not use the living space for commercial room rentals as holiday apartments. STACEY members are not allowed to sublet the apartment to third parties. The private rooms can not be locked by the tenant. The tenant agrees the personell from STACEY is allowed to enter the apartments. However, the STACEY personell, except of the cleaning team, is not allowed to enter the private rooms without the presence of prior approval of the tenant.</Text>
              <Text style={styles.paragraph}>The contractual obligations of STACEY include but are not limited to making a room available for sole private use by the user; providing access to and allowing shared use of the shared space within the property; providing furniture for the rented room and the shared space of the property; internet service (subject to 'Terms of Conditions of Internet Use' here attached and part of the agreement); organization of a weekly cleaning service (for furnished rooms and common areas); maintenance or repair of the facilities if such need [for maintenance or repair] arises from using the property in compliance with the agreement.</Text>
              <Text style={styles.paragraph}>Members are individually responsible for how they organize the communal life in the shared apartment. The lessor may post pictures and videos of the lessee, that originate within the communal life of the STACEY community, online.</Text>
              <Text style={styles.paragraph}>The duration of the tenants stay is limited to the rent duration, as the property will experience major physical alteration after the end of the tenant's lease period. The homeowner will conduct the refurbishment of the house's facade, snaitary- & electrical installations, as well as the house's roof. Due to the construction measures, the layout of the leased room will change. The utilization of the room by the tenant is an obstruction during the refurbishment of the listed measures above. Thus, it is in the interest of the lessor that the room will not be hired out till the end of the construction & refurbishment.</Text>
              <Text style={styles.paragraph}>The rental period starts on the {moment(moveIn).format('DD/MM/YYYY')} and ends on the {moment(moveOut).format('DD/MM/YYYY')}.</Text>
            </View>
            <View style={styles.sectionBody} wrap={false}>
              <Text style={styles.bodyHeader}>2. Contract Signing</Text>
              <Text style={styles.paragraph}>On its website, STACEY publishes pictures of a variety of generic rooms, common areas, etc., which show the different residential designs on its website.</Text>
              <View style={styles.listItem}>
                <Text style={styles.listCount}>1.</Text>
                <Text>If the customer is interested in the offer, he the can clicks the button “APPLY”. When a customer applies STACEY gets the personal information of the user. The customer will then receive a YES or NO answer on his application, which is based on the information provided and the availability of rooms at that specific moment.</Text>
              </View>
              <View style={styles.listItem}>
                <Text style={styles.listCount}>2.</Text>
                <Text>The customer can access the STACEY booking platform where he finds more information and images concerning the available suites.</Text>
              </View>
              <View style={styles.listItem}>
                <Text style={styles.listCount}>3.</Text>
                <Text>By selecting an avaiable suite for a specific date range the customer is forward to the tenancy agreement for the desired room of the prospective tenant. The tenant concludes the official contract with the signing of the rental agreement online. The tenant has the opportunity to download a copy of the rental agreement at any time.</Text>
              </View>
              <View style={styles.listItem}>
                <Text style={styles.listCount}>4.</Text>
                <Text>The STACEY member shall inform the local registration office of his new place of residence or secondary residence within two weeks of moving according to the Meldegesetz (German Registration Act).</Text>
              </View>
            </View>
            <View style={styles.sectionBody} wrap={false}>
              <Text style={styles.bodyHeader}>3. Contractual obligation</Text>
              <Text style={styles.paragraph}>In signing an effective rental agreement, the STACEY member undertakes to pay the monthly rent specified in the individual agreement. Rent is transferred to the STACEY Real Estate UG through the direct debit mandate at the commencement of the periods of time according to which it is computed but at the latest by the third business day of each such period.</Text>
              <Text style={styles.paragraph}>The member agrees to a direct debit mandate with STACEY and provides [other necessary] payment details, and shall immediately notify STACEY of any changes thereto.</Text>
              <Text style={styles.paragraph}>Monthly rent is all-inclusive. The rent includes ongoing costs, in particular utilities and incidental expenses.</Text>
              <Text style={styles.paragraph}>In case the STACEY member is in default with paying the monthly rent, the STACEY member shall pay interest at 5% over the basic interest rate on the monthly rent during the late payment period. STACEY may terminate extraordinary per $ 543 subsection (2) No. 3 BGB, if the STACEY member is in default, on two successive times, of payment of the rent or a portion of the rent that is not insignificant, or in a period of time spanning more than two times is in default of payment of the rent in an amount that is as much as the amount of rent for two months.</Text>
              <Text style={styles.paragraph}>The monthly rent does not include costs of any repairs and maintenance required in connection with damage caused through the member's fault.</Text>
              <Text style={styles.paragraph}>STACEY may separately bill any additionally performed services only with prior consent of the user.</Text>
            </View>
            <View style={styles.sectionBody} wrap={false}>
              <Text style={styles.bodyHeader}>4. Deposit</Text>
              <Text style={styles.paragraph}>Upon signing the contract the lessee pays a deposit that, depending on the length of the lease period, shall not exceed the sum of three basic rental charges (total rent excl. service charge). The deposit has to be paid via bank transfer to the STACEY bank account as specified in the contract.</Text>
              <Text style={styles.paragraph}>The deposit serves as a security for the lessor who is allowed to deduct any claims that arise under this contract from the deposit.</Text>
            </View>
            <View style={styles.sectionBody} wrap={false}>
              <Text style={styles.bodyHeader}>5. Termination</Text>
              <Text style={styles.paragraph}>The termination is not possible during the rent period as it is a fixed-term tenancy agreement. The lesor has the right to withdraw from the contract till 1 month before the start date, as well as in the period of 2 days after receiving the signed rental agreement from the tenant.</Text>
            </View>
            <View style={styles.sectionBody} wrap={false}>
              <Text style={styles.bodyHeader}>6. Extraordinary termination of mermbership</Text>
              <Text style={styles.paragraph}>STACEY may terminate the extraordinarily independently of the existence of the existence of the lease if the member seriously violates this Rental Agreement or any of the terms at www.stacey-living.de/terms.</Text>
              <Text style={styles.paragraph}>A serious violation is deemed to be committed, in particular, when the member continously disrupts the peaceful cohabitation within the residential community, or violates the rules of conduct as defined in section 5 or creates multiple member accounts, uses the website in a manner violating applicable law, provides false, out-of-date or incomplete information during the registration process or fails to update same.</Text>
              <Text style={styles.paragraph}>Reasons for extraordinary termination are:</Text>
              <View style={styles.listItem}>
                <Text style={styles.listCount}>-</Text>
                <Text>Subletting room on Airbnb, equivalents or else to third parties</Text>
              </View>
              <View style={styles.listItem}>
                <Text style={styles.listCount}>-</Text>
                <Text>Incorporate use of internet (= "Terms of Conditions of Internet Use" see Point (2))</Text>
              </View>
              <View style={styles.listItem}>
                <Text style={styles.listCount}>-</Text>
                <Text>Persistent breach of house rules (see Point (3))</Text>
              </View>
              <View style={styles.listItem}>
                <Text style={styles.listCount}>-</Text>
                <Text>Permanently payment defaults</Text>
              </View>
              <View style={styles.listItem}>
                <Text style={styles.listCount}>-</Text>
                <Text>Disturbance of domestic peace</Text>
              </View>
              <View style={styles.listItem}>
                <Text style={styles.listCount}>-</Text>
                <Text>Breach the pet-ban, smoking-ban, drugs-ban</Text>
              </View>
              <View style={styles.listItem}>
                <Text style={styles.listCount}>-</Text>
                <Text>Deliberate damages to the rental object</Text>
              </View>
              <View style={styles.listItem}>
                <Text style={styles.listCount}>-</Text>
                <Text>Running a business in his/her own apartment</Text>
              </View>
            </View>
            <View style={styles.sectionBody} wrap={false}>
              <Text style={styles.bodyHeader}>7. Damage</Text>
              <Text style={styles.paragraph}>The lessee shall report any identified damage to the facilities within 48 hours of moving in. If no such report is made, the room is deemed to be accepted in a condition compliant with the Agreement.</Text>
              <Text style={styles.paragraph}>Any damage to the facilities of the rented room or the shared space and the rooms identified later on must be photographically documented by the member and notified to STACEY within 48 hours of identifying such damage. Any costs of defects caused by the member in connection with using the property in a manner contrary to the Agreement or resulting from late notification of a defect shall be borne by the member.</Text>
              <Text style={styles.paragraph}>If the damage in the shared spaces cannot be associated with one individual member, the damage costs are split between all tenants within the community.</Text>
            </View>
            <View style={styles.sectionBody} wrap={false}>
              <Text style={styles.bodyHeader}>8. Special events</Text>
              <Text style={styles.paragraph}>The lessor has the right to relocate the tenant to a different room within the STACEY network. This room has to be the same or a better room category mentioned in the agreement.</Text>
            </View>
            <View style={styles.sectionBody} wrap={false}>
              <Text style={styles.bodyHeader}>9. Right of withdrawal</Text>
              <Text style={styles.paragraph}>If the user is a consumer within the meaning of §13 BGB [German Civil Code], he has the right of withdrawal as per § 355 BGB in respect of the membership agreement, provided that the agreement is a distance contract as per § 312 c BGB.</Text>
              <Text style={styles.paragraph}>According to § 312 c BGB, distance contracts are contracts for which the trader, or a person acting in the trader's name or on his behalf, and the consumer exclusively avail themselves of means of distance communication in negotiating and concluding the contract, unless the contract is concluded via a sales or a service system designated for distance sales.</Text>
              <Text style={styles.paragraph}>Means of distance communication in this context are all means of communication which can be used to initiate or to conclude a contract, without requiring the simultaneous physical presence of the parties to the contract, such as letters, catalogues, telephone calls, faxes, emails, text messages sent via the mobile telephone service (SMS) as well as messages broadcast and sent via teleservices.</Text>
            </View>
            <View style={styles.sectionBody} wrap={false}>
              <Text style={styles.bodyHeader}>10. Severability</Text>
              <Text style={styles.paragraph}>If a provision of this agreement is or becomes leagally invalid or if there is any gap that needs to be filled, the valiedity of the remainder of the agreement shall not be affected therby. Invalid provisions shall be replaced by common consent with such provisions which come as close as possible to the intended result of the invalid provision.</Text>
              <Text style={styles.paragraph}>In the event of gaps such provision shall come into force by common consent which comes as close as possible to the intended result of the agreement, should matter have been considered in advance. Any changes of or amendments to this agrrement mus be in writing to become effective</Text>
            </View>
            {
              this.signContract(contract, user)
            }
          </View>
          <View style={styles.section} wrap={false}>
            <Text style={[styles.underline, styles.bodyHeader]}>INFROMATION OF THE RIGHT OF WITHDRAWAL</Text>
            <View style={styles.sectionBody}>
              <Text style={styles.bodyHeader}>Right of withdrawal</Text>
              <Text>You are entitled to withdraw from the membership within 14 days without giving reasons. The time limit for the withdrawal is 14 days from the date of concluding the agreement. However, by moving-in within the period of 14 days after signing the agreement, you accept that you loose your right to exercise the right of withdrawal.</Text>
              <Text>To exercise the right of withdrawal, please inform us (STACEY Real Estate UG (haftungsbeschränkt), Brandstwiete 36, 20457 Hamburg, phone.: 040 696389600, email: hello@stacey-living.de) of your decision to withdraw from the Agreement as per item 8, by submitting a clearly worded declaration (e.g. by sending a letter by post, or sending a fax or email). You can use the attached withdrawal form template for this purpose, but the use of this form is not mandatory.</Text>
              <Text style={styles.paragraph}>In order to meet the withdrawal deadline it is sufficient to send the information about the exercise of the right of withdrawal before the end of the withdrawal deadline.</Text>
              <Text style={styles.bodyHeader}>Consequences of withdrawal</Text>
              <Text style={styles.paragraph}>If you withdraw from this Agreement, we will return all payments immediately, no later than 14 days of the date on which we received the notice of your withdrawal from this Agreement. We will refund the above expenses using the same means of payment as you used for the original transaction unless expressly agreed otherwise with you; in no case will we charge you a fee for this refund. If your requested period of service performance overlaps with the withdrawal period, you will have to pay us an appropriate fee equal to the portion payable for the services performed until the date on which you informed us that you withdraw from the Agreement in relation to the entire scope of services provided for in the agreement.</Text>
              <Text style={styles.bodyHeader}>Withdrawal form template:</Text>
              <Text style={styles.paragraph}>If you wish to withdraw from the agreement as per the paragraphs above, you can complete and submit this form. You are not required to use this form, though.</Text>
              <Text>I/We (*) hereby withdraw from the agreement signed by me/us (*) on the provision of the following services (*)</Text>
              <Text>Ordered on (*)/received on (*)</Text>
              <Text>Name of the consumer(s)</Text>
              <Text>Postal address of the consumer(s)</Text>
              <Text>Signature of the consumer(s) (only if notification is in paper form)</Text>
              <Text>Date</Text>
              <Text>(*) delete as appropriate.</Text>
            </View>
          </View>
          <View style={styles.section}>
            <Text style={styles.sectionHeader} break>(2) TERMS AND CONDITIONS FOR INTERNET USE</Text>
            <View style={styles.sectionBody} wrap={false}>
              <Text style={styles.bodyHeader}>1. Mode and duration of the internet use</Text>
              <Text style={styles.paragraph}>1.1 The lessee is allowed to use the internet access point available in the rented apartment in accordance with the following terms and conditions.</Text>
              <Text style={styles.paragraph}>1.2 The lessee may use the internet access in a normal, reasonable way (e- mailing, surfing, downloading, etc.). Any use that violates copyrights, trademarks, personal rights or that falls under criminal law provisions is prohibited. Particularly forbidden is:</Text>
              <View style={styles.listItem}>
                <Text style={styles.listCount}>-</Text>
                <Text>Any sort of file sharing and any use of file sharing software, peer-to-peer and bittorrent networks, etc.</Text>
              </View>
              <View style={styles.listItem}>
                <Text style={styles.listCount}>-</Text>
                <Text>The violation of copyrights or other legally protected rights by up- or downloading content protected by copyright (movies, music, software, etc.)</Text>
              </View>
              <View style={styles.listItem}>
                <Text style={styles.listCount}>-</Text>
                <Text>Insulting or humiliating other individuals</Text>
              </View>
              <View style={styles.listItem}>
                <Text style={styles.listCount}>-</Text>
                <Text>Sharing photos of other people without permission</Text>
              </View>
              <View style={styles.listItem}>
                <Text style={styles.listCount}>-</Text>
                <Text>Publishing harmful and/or illegal content</Text>
              </View>
              <View style={styles.listItem}>
                <Text style={styles.listCount}>-</Text>
                <Text>Sending mass-e-mails (spamming)</Text>
              </View>
              <View style={styles.listItem}>
                <Text style={styles.listCount}>-</Text>
                <Text>Spreading computer viruses</Text>
              </View>
              <View style={styles.listItem}>
                <Text style={styles.listCount}>-</Text>
                <Text>Visiting websites with indictable content (hate-speech, child- or underage pornography, violence-glorifying, etc.) or which contain links to such content</Text>
              </View>
              <View style={styles.listItem}>
                <Text style={styles.listCount}>-</Text>
                <Text>Entering (or trying to enter) foreign data-networks, which are not meant for public access (hacking).</Text>
              </View>
              <Text style={styles.paragraph}>1.3 The lessee shall not use any online services that cause claims against the lessor.</Text>
            </View>
            <View style={styles.sectionBody} wrap={false}>
              <Text style={styles.bodyHeader}>2. Login data</Text>
              <Text style={styles.paragraph}>2.1 The lessee shall maintain the secrecy of the login data provided by the lessor (SSID of the wireless network, network key, etc.). He shall not reveal it to any third person without permission of the lessor. This obligation also applies after the expiration of the contract term.</Text>
              <Text style={styles.paragraph}>2.2 In case the lessee finds out that a third person – for whatever reason – has knowledge about the login data, he is obliged to immediately inform the lessor so that he can secure the internet access by changing the login data.</Text>
            </View>

            <View style={styles.sectionBody} wrap={false}>
              <Text style={styles.bodyHeader}>3. Availability of the internet access</Text>
              <Text style={styles.paragraph}>3.1 The internet access is only provided within the limits of the technical requirements and the contract with the access provider of the apartment’s internet access point. The lessee is not entitled to claim a minimum band width or other performance features.</Text>
              <Text style={styles.paragraph}>3.2 The lessor is not liable for any disfunction of the internet access because of force majeure, line fault or maintenance activity by the internet provider. The lessor guarantees no minimum level of service, nor for a permanent availability of the internet access.</Text>
            </View>

            <View style={styles.sectionBody} wrap={false}>
              <Text style={styles.bodyHeader}>4. Liability of the lessee</Text>
              <Text style={styles.paragraph}>4.1 The lessee is responsible for all his activities in the internet as well as for all content he up or downloads.</Text>
              <Text style={styles.paragraph}>4.2 The lessee releases the lessor from any liability or damage that arises from the violation of these terms and conditions of the internet use. In case the internet use by the lessee causes any costs to the lessor the lessee shall reimburse the lessor for these costs.</Text>
            </View>

            <View style={styles.sectionBody} wrap={false}>
              <Text style={styles.bodyHeader}>5. liability and Rights of the lessor</Text>
              <Text style={styles.paragraph}>5.1 The lessor shall not be liable for any damage that happens to the lessee in connection with the internet use. That applies particularly to damage of the lessee’s computer, to virus attacks and to content used by the lessee (on the hard-drive and / or in the internet). That, however, does not apply in case of deliberate or grossly negligent conduct of the lessor.</Text>
              <Text style={styles.paragraph}>5.2 The lessor is allowed to immediately block the internet access without substitution in case the lessee violates these terms and conditions for the internet use. In the case of persistent breach of these terms and conditions for internet using the lessor is allowed to terminate the lease extraordinary.</Text>
            </View>
            {
              this.signContract(contract, user)
            }
          </View>
          <View style={styles.section}>
            <Text style={styles.sectionHeader} break>(3) House Rules</Text>
            <View style={styles.sectionBody} wrap={false}>
              <Text style={styles.bodyHeader}>A. Mutual Consideration</Text>
              <View style={styles.listItem}>
                <Text style={styles.listCount}>-</Text>
                <Text>Avoid disturbing noises inside the lessee's apartment, inside the house, in the courtyard and on the property as far as possible, in particular through the use of technical equipment, through heavy doors slamming and stairs running or through heavy music making.</Text>
              </View>
              <View style={styles.listItem}>
                <Text style={styles.listCount}>-</Text>
                <Text>Set the radio, tv, cd-player etc. to room volume at any time. Be more considerate in time of the lunch break from 1pm to 3 pm as well as in time of the night rest form 10 pm to 6 am.</Text>
              </View>
            </View>
            <View style={styles.sectionBody} wrap={false}>
              <Text style={styles.bodyHeader}>B. User of common spaces</Text>
              <View style={styles.listItem}>
                <Text style={styles.listCount}>-</Text>
                <Text>Remove your own items from common areas when leaving (i.e. clothes, water bottles, laptops, phones, keys, exc...)</Text>
              </View>
              <View style={styles.listItem}>
                <Text style={styles.listCount}>-</Text>
                <Text>No signs are allowed on each tenants individual door or in the common space of the building</Text>
              </View>
              <View style={styles.listItem}>
                <Text style={styles.listCount}>-</Text>
                <Text>Do not leave the building door open. Please close all doors to avoid external people entering the building and guaranteeing the security of all tenants. Do not attach your own names on the mailbox: the PROJECTS team has to take care of this in compliance with the rules of the building. We will provide you with the correct c/o to address your mail</Text>
              </View>
              <View style={styles.listItem}>
                <Text style={styles.listCount}>-</Text>
                <Text>Do not leave trash in the hallway</Text>
              </View>
            </View>
            <View style={styles.sectionBody} wrap={false}>
              <Text style={styles.bodyHeader}>C. Use of shared kitchens</Text>
              <View style={styles.listItem}>
                <Text style={styles.listCount}>-</Text>
                <Text>Put items in the dishwasher when finished using</Text>
              </View>
              <View style={styles.listItem}>
                <Text style={styles.listCount}>-</Text>
                <Text>Once you see dishwasher is at max capacity please make the dishwasher run</Text>
              </View>
              <View style={styles.listItem}>
                <Text style={styles.listCount}>-</Text>
                <Text>If you dishwasher is done running, please remove and place items in shelves</Text>
              </View>
              <View style={styles.listItem}>
                <Text style={styles.listCount}>-</Text>
                <Text>If you see a full trash bag, please bring the trash out.</Text>
              </View>
            </View>
            <View style={styles.sectionBody} wrap={false}>
              <Text style={styles.bodyHeader}>D. Use of shared bathrooms</Text>
              <View style={styles.listItem}>
                <Text style={styles.listCount}>-</Text>
                <Text>Always clean after youself in respect of your roommmates</Text>
              </View>
              <View style={styles.listItem}>
                <Text style={styles.listCount}>-</Text>
                <Text>Limit the amount of personal items you leave in the bathroom, use storage units provided in bathrooms and bedrooms.</Text>
              </View>
            </View>
            <View style={styles.sectionBody} wrap={false}>
              <Text style={styles.bodyHeader}>F. Smoking and Drugs Consumption</Text>
              <View style={styles.listItem}>
                <Text style={styles.listCount}>-</Text>
                <Text>Smoking is not allowed inside the house</Text>
              </View>
              <View style={styles.listItem}>
                <Text style={styles.listCount}>-</Text>
                <Text>Smoking is allowed on balconies with closed windows</Text>
              </View>
              <View style={styles.listItem}>
                <Text style={styles.listCount}>-</Text>
                <Text>Do not throw the cigarette stub off the balconies</Text>
              </View>
              <View style={styles.listItem}>
                <Text style={styles.listCount}>-</Text>
                <Text>Using drugs is not allowed inside or in front of the house</Text>
              </View>
            </View>
            <View style={styles.sectionBody} wrap={false}>
              <Text style={styles.bodyHeader}>E. Pets</Text>
              <Text style={styles.paragraph}>The STACEY Member cannot keep any animal without the permission of STACEY.</Text>
            </View>
            <View style={styles.sectionBody} wrap={false}>
              <Text style={styles.bodyHeader}>F. Guests</Text>
              <View style={styles.listItem}>
                <Text style={styles.listCount}>-</Text>
                <Text>Day time guests are allowed at any time</Text>
              </View>
              <View style={styles.listItem}>
                <Text style={styles.listCount}>-</Text>
                <Text>Overnight guests are allowed for a maximum consecutive time of 7 days and max 7 days per month cumulative</Text>
              </View>
              <View style={styles.listItem}>
                <Text style={styles.listCount}>-</Text>
                <Text>Guests must always sleep in your room, it is not allowed for them to sleep in common areas (couches) nor in other rooms, even when vacant</Text>
              </View>
              <View style={styles.listItem}>
                <Text style={styles.listCount}>-</Text>
                <Text>If you want to invite an out of ordinary amount of guests that can be disruptive you must receive approval from your cohabitants.</Text>
              </View>
            </View>
            <View style={styles.sectionBody} wrap={false}>
              <Text style={styles.bodyHeader}>G. Miscellaneous</Text>
              <Text style={styles.paragraph}>It is not allowed to bring or buy your own furniture nor hang things on the wall. If you need any additional items, please contact us first and we will try to find a solution for you.</Text>
            </View>
            {
              this.signContract(contract, user)
            }
          </View>
        </Page>
      </Document>
    )
  }
};

export default ContractPdfDocument;
