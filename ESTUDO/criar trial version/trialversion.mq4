void OnStart(){
    datetime starts = D'05.07.2019';
    datetime ends   = D'05.08.2019';

    if (TimeCurrent() > starts && TimeCurrent() < ends){
        //code of the expert
    }

    if(TimeCurrent() == ends){
        Alert('Trial version time is over!');
    }
}