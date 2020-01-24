import {Component, HostListener, OnInit} from '@angular/core';
import {HttpClient, HttpHeaders} from '@angular/common/http';

@Component({
  selector: 'app-payment-demo',
  templateUrl: './payment-demo.component.html',
  styleUrls: ['./payment-demo.component.scss']
})
export class PaymentDemoComponent implements OnInit {
  public userName = 'SuperUser';
  public password = 'sys';
  //public url = '/csp/appint/rest/transaction/';
  public url = 'http://' + window.location.hostname + ':9092/csp/appint/rest/transaction/';
  public currentDate: number = Date.now();
  public currentTime: number = Date.now();
  public clickBtnSound = new Audio();
  public requestValue = {
    TransType: 'PAYMENT',
    Amount: '0',
    FromAccountNumber: 'C1822295676',
    ToAccountNumber: 'M1353266412'
  };
  public isCreditCardInserted = false;
  public Object = Object;
  public terminal = {
    state: {
      isInitial: true,
      isWaiting: false,
      isWorking: false,
      isApproved: false,
      isDeclined: false
    }
  };
  public response;

  // Listen keyboard
  @HostListener('document:keydown', ['$event'])
  handleKeyboardEvent(event: any) {
    if (!isNaN(event.key)) {
      this.updateValue(+event.key);
    } else if (event.key === 'Enter' && this.terminal.state.isInitial) {
      this.askCreditCard();
    } else if (event.key === 'Enter' && this.terminal.state.isWaiting) {
      this.insertCreditCard();
    } else if (event.key === 'Enter' && (this.terminal.state.isDeclined || this.terminal.state.isApproved)) {
      this.resetDemo();
    } else if (event.key === 'Escape' && this.terminal.state.isInitial) {
      this.clearValue();
    } else if (event.key === 'Backspace' && this.terminal.state.isInitial) {
      this.deleteLastSymbol();
    }
  }

  constructor(private http: HttpClient) {
  }

  ngOnInit() {
    //  load click button sound
    this.clickBtnSound.src = '../../assets/sounds/btn-click.mp3';
    this.clickBtnSound.load();
    // update current time every minute
    setInterval(() => {
      this.currentTime = Date.now();
    }, 60 * 1000);
  }

  updateValue(num: number) {
    if (!this.terminal.state.isInitial) {
      return;
    }
    let value = this.requestValue.Amount;
    if (+this.requestValue.Amount === 0 && num === 0) {
      return;
    } else if (+this.requestValue.Amount === 0) {
      value = value.slice(0, -1);
    }
    this.requestValue.Amount = value + num;
    this.playBtnClickSound();
  }

  deleteLastSymbol() {
    if (!this.terminal.state.isInitial) {
      return;
    }
    let value = this.requestValue.Amount;
    value = value.slice(0, -1);
    this.requestValue.Amount = value;
    if (value.length === 0) {
      this.requestValue.Amount = '0';
      this.terminal.state.isInitial = true;
    }
    this.playBtnClickSound();
  }

  clearValue() {
    if (!this.terminal.state.isInitial) {
      return;
    }
    this.requestValue.Amount = '0';
    this.terminal.state.isInitial = true;
    this.playBtnClickSound();
  }

  askCreditCard() {
    if (!this.terminal.state.isInitial) {
      return;
    }
    this.nullTerminalStates();
    this.terminal.state.isWaiting = true;
    this.playBtnClickSound();
  }

  insertCreditCard() {
    this.isCreditCardInserted = true;
    this.nullTerminalStates();
    this.terminal.state.isWorking = true;
    this.sendRequest();
    setTimeout(() => {
      this.nullTerminalStates();
      if (this.response.TransactionResult.Approved) {
        this.terminal.state.isApproved = true;
      } else {
        this.terminal.state.isDeclined = true;
      }
    }, 2 * 1000);
  }

  playBtnClickSound() {
    this.clickBtnSound.play();
  }

  nullTerminalStates() {
    Object.keys(this.terminal.state).forEach(key => {
      this.terminal.state[key] = false;
    });
  }

  sendRequest()
  {
    const options =
    {
      headers: new HttpHeaders({
        'Content-Type': 'application/json; charset=utf-8',
        'Authorization': 'Basic ' + btoa(this.userName + ':' + this.password),
      }),
    };
    this.http.post(this.url, this.requestValue, options).subscribe((r) => {
      this.response = r;
    });
  }

  resetDemo() {
    this.requestValue.Amount = '0';
    this.isCreditCardInserted = false;
    this.nullTerminalStates();
    this.terminal.state.isInitial = true;
  }

}
