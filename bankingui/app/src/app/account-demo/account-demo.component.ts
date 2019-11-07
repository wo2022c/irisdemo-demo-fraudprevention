import {Component, OnInit} from '@angular/core';
import {HttpClient, HttpHeaders} from '@angular/common/http';

export class User {
  public static accountNumber = 'C1822295676';
  public static userLogin = 'SuperUser';
  public static userPassword = 'sys';
}

@Component({
  selector: 'app-account-demo',
  templateUrl: './account-demo.component.html',
  styleUrls: ['./account-demo.component.scss']
}) 

export class AccountDemoComponent implements OnInit {
  public transactionsHistory;
  
  public accountTabs = {
    isOnlineBank: false,
    isHistory: true,
    isTransfer: false,
    isSettings: false,
  };

  public settingsSections = {
    isFraudProtection: true,
    isLoginAndPassword: false,
    isPersonalInformation: false,
    isInterfaceLanguage: false
  };

  public isProtectionEnabled = true;
  public startProtectionDate;
  public endProtectionDate;
  public transferAmount;
  public filterDateStart = this.formatDate(new Date(), true);
  public filterDateEnd = this.formatDate(new Date());

  public transferState = {
    isInitial: true,
    isSuccess: false,
    isFailed: false
  };

  public response;

  constructor(private http: HttpClient) {
  }

  ngOnInit() {
    //END POINT NOT IMPLEMENTED
    //this.getFilteredTransactions('startDateExample', 'endDateExample');
  }

  formatDate(date: Date, minusMonth: boolean = false) {
    const d = new Date(date),
      year = d.getFullYear();
    let month: number | string = (d.getMonth() + 1),
      day = '' + d.getDate();

    if (minusMonth) {
      month -= 1;
      if (month <= 0) {
        month = 12;
      }
    }

    month = '' + month;

    if (month.length < 2) {
      month = '0' + month;
    }
    if (day.length < 2) {
      day = '0' + day;
    }

    return [year, month, day].join('-');
  }

  nullAccountTabs() {
    Object.keys(this.accountTabs).forEach(key => {
      this.accountTabs[key] = false;
    });
  }

  goToHistory() {
    this.nullAccountTabs();
    this.accountTabs.isHistory = true;
  }

  goToTransfer() {
    this.nullAccountTabs();
    this.accountTabs.isTransfer = true;
  }

  goToSettings() {
    this.nullAccountTabs();
    this.accountTabs.isSettings = true;
  }

  nullTransferState() {
    Object.keys(this.transferState).forEach(key => {
      this.transferState[key] = false;
    });
  }

  doTransfer() {
    this.nullTransferState();
    if (this.transferAmount > 0) {
      this.transferState.isSuccess = true;
    } else {
      this.transferState.isFailed = true;
    }
  }

  nullSettingsSections() {
    Object.keys(this.settingsSections).forEach(key => {
      this.settingsSections[key] = false;
    });
  }

  expandFraudProtection() {
    this.nullSettingsSections();
    this.settingsSections.isFraudProtection = true;
  }

  expandLoginAndPassword() {
    this.nullSettingsSections();
    this.settingsSections.isLoginAndPassword = true;
  }

  expandPersonalInformation() {
    this.nullSettingsSections();
    this.settingsSections.isPersonalInformation = true;
  }

  expandInterfaceLanguage() {
    this.nullSettingsSections();
    this.settingsSections.isInterfaceLanguage = true;
  }

  sendRequest(endpoint:string, requestValue: object, subscribeFunction: Function) 
  {
    const options = 
    {
      headers: new HttpHeaders({
        'Content-Type': 'application/json; charset=utf-8',
        'Authorization': 'Basic ' + btoa(User.userLogin + ':' + User.userPassword),
      }),
    };

    this.http.post(endpoint, requestValue, options).subscribe((data) => { subscribeFunction(data); });
  }

  toggleProtection() 
  {

    this.sendRequest('http://localhost:9092/csp/appint/rest/whitelist/',
    {
      FromAccountNumber: User.accountNumber,
      FromDate: this.startProtectionDate,
      ToDate: this.endProtectionDate
    }, 
    (data) => {
      this.isProtectionEnabled = !this.isProtectionEnabled; // data.isEnabled
      }
    );
    
  }

  getFilteredTransactions(startDate, endDate) 
  {
    this.http.post('/csp/appint/rest/transaction/list/',
      {
        AccountNumber: User.accountNumber,
        FromDate: this.filterDateStart,
        ToDate: this.filterDateEnd
      }
    ).subscribe((data: any) => {
      this.transactionsHistory = data.transactionsHistory;
    }, (e) => {
      console.log(e);
    });
  }
}
