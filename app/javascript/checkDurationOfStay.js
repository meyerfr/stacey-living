const date = document.getElementById('user_move_in_date_3i').value;

function checkDateDiffernce() {
  let move_in_date_day = parseInt(document.getElementById('user_move_in_date_3i').value);
  let move_in_date_month = parseInt(document.getElementById('user_move_in_date_2i').value);
  let move_in_date_year = parseInt(document.getElementById('user_move_in_date_1i').value);


  let move_out_date_day = parseInt(document.getElementById('user_duration_of_stay_3i').value);
  let move_out_date_month = parseInt(document.getElementById('user_duration_of_stay_2i').value);
  let move_out_date_year = parseInt(document.getElementById('user_duration_of_stay_1i').value);

  let move_in_date = new Date(`${move_in_date_year}, ${move_in_date_month}, ${move_in_date_day}`);
  let move_out_date = new Date(`${move_out_date_year}, ${move_out_date_month}, ${move_out_date_day}`);
  const diffTime = Math.abs(move_out_date.getTime() - move_in_date.getTime());
  const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));
  const diffMonth = diffDays / 30;
  console.log(move_in_date);
  console.log(move_out_date);
  console.log(diffMonth);
  if(diffMonth < 3){
    return true
  }else{
    return false
  }
}

const checkDurationErrors = (event) => {
  if (checkDateDiffernce() === true){
    document.querySelector('.duration-of-stay-error').classList.remove('hidden');
  }else{
    document.querySelector('.duration-of-stay-error').classList.add('hidden');
  }
}

function checkDuration() {
  console.log('checkDuration');
  if(date){
    document.getElementById('user_duration_of_stay_2i').addEventListener('change', checkDurationErrors);
    console.log('function checkDurationErrors runs')
  };
};

export{ checkDuration };
