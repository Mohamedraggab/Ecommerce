import 'package:e_commerce/core/controller/pay_cubit/pay_states.dart';
import 'package:e_commerce/core/network/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce/core/constants.dart';

class PayCubit extends Cubit<PayState>
{
  PayCubit() : super(InitPayState());

  static PayCubit get(context) => BlocProvider.of(context);


  getToken()
  {
    emit(InitGetTokenPayState());
    DioHelper.postData(url: GetConst.getTokenUri, query: {
      "api_key": GetConst.apiKey,
    })
        .then((value){
          emit(SuccessGetTokenPayState());
          GetConst.token = value.data['token'].toString();
          print('the token is ${value.data['token'].toString()}');

    })
        .catchError((error){
          emit(ErrorGetTokenPayState());
          print("the error of get token is ${error.toString()}");
    });
  }



  getOrderId({
    required String price,
    required String firstName,
    required String phoneNumber,
    required String lastName,
})
  {
    emit(InitGetOrderIdPayState());
    DioHelper.postData(url: GetConst.getIdOrderUri, query: {
      "auth_token":  GetConst.token,
      "delivery_needed": "false",
      "amount_cents": price,
      "currency": "EGP",
      "items": []
    })
        .then((value){
      GetConst.orderId = value.data['id'].toString();
      print('the id is ${value.data['id'].toString()}');
      emit(SuccessGetOrderIdPayState());
      getPaymentRequest(price: price, firstName: firstName, phoneNumber: phoneNumber, lastName: lastName);

    })
        .catchError((error){
      emit(ErrorGetOrderIdPayState());
      print("the error of get orderId is ${error.toString()}");
    });
  }


  getPaymentRequest({
    required String price,
    required String firstName,
    required String phoneNumber,
    required String lastName,
})
  {
    emit(InitGetFinalTokenPayState());
    DioHelper.postData(url: GetConst.getFinalTokenUri, query: {

        "auth_token": GetConst.token,
        "amount_cents": price,
        "expiration": 3600,
        "order_id": GetConst.orderId,
        "billing_data": {
          "apartment": "N/A",
          "email": "N/A",
          "floor": "N/A",
          "first_name": firstName,
          "street": "N/A",
          "building": "N/A",
          "phone_number": phoneNumber ,
          "shipping_method": "N/A",
          "postal_code": "N/A",
          "city": "N/A",
          "country": "N/A",
          "last_name": lastName,
          "state": "N/A"
        },
        "currency": "EGP",
        "integration_id": GetConst.integrationCardId,
        "lock_order_when_paid": "false"
    })
        .then((value){
      emit(SuccessGetFinalTokenPayState());
      GetConst.finalToken = value.data['token'].toString();
      print('the finalToken is ${value.data['token'].toString()}');
      getRefCode( ref: value.data['token'].toString());

    })
        .catchError((error){
      emit(ErrorGetFinalTokenPayState());
      print("the error of get final token is ${error.toString()}");
    });
  }


  getRefCode({
    required String ref ,
})
  {
    emit(InitGetRefCodePayState());
    DioHelper.postData(url: GetConst.getFinalTokenUri, query:
    {
      "source": {
        "identifier": "AGGREGATOR",
        "subtype": "AGGREGATOR"
      },
      "payment_token": ref,
    } )
        .then((value){
      GetConst.refCode = value.data['id'].toString();
      print('the refCode is ${value.data['id'].toString()}');
      emit(SuccessGetRefCodePayState());


    })
        .catchError((error){
      emit(ErrorGetRefCodePayState());
      print("the error of get refCode is ${error.toString()}");
    });
  }






  


}