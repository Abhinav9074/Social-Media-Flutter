String dateDiffernce(DateTime today, DateTime date) {
  
     today = DateTime(today.year, today.month, today.day,today.hour,today.minute,today.second);
     date = DateTime(date.year, date.month, date.day,date.hour,date.minute,date.second);
    var val = (today.difference(date).inHours).round();
    
    if(val==0){
      if((today.difference(date).inMinutes)==0){
        if((today.difference(date).inSeconds)<=10){
          return 'Just now';
        }else{
          return '${(today.difference(date).inSeconds)} Seconds ago';
        }
      }
      if((today.difference(date).inMinutes)==1){
        return '${(today.difference(date).inMinutes)} Minute ago';
      }else{
        return '${(today.difference(date).inMinutes)} Minutes ago';
      }
    }
    if(val>24){
      if(val~/24==1){
        return '${val~/24} Day ago';
      }else{
        return '${val~/24} Days ago';
      }
    }
    if(val>168){
      if(val~/168==1){
        return '${val~/168} Week ago';
      }else{
        return '${val~/168} Weeks ago';
      }
    }
   if(val==1){
    return '$val Hour ago';
   }else{
    return '$val Hours ago';
   }
  }