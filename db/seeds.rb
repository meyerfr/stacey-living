# require "open-uri"

# change mühlenlamp mighty price for 9+ Month back to live mode - price_1HaJN3HP1DTF1I43NtoUdBzx
# delete booking by meyerfr@gmx.de for mühlenkamp mighty room

# stripe = [
#   { project: 'Eppendorf', roomtype: 'Mighty', prices: ['price_1HaJMgHP1DTF1I43zTlytvv3', 'price_1HaJMgHP1DTF1I43QZKLVyag', 'price_1HaJMgHP1DTF1I435fEAfxal'], stripe_product_id: 'prod_IAegbiIgW9uzBT' },
#   { project: 'Eppendorf', roomtype: 'Mighty+', prices: ['price_1HaJMbHP1DTF1I43lICs9FOz', 'price_1HaJMbHP1DTF1I436GuxUNdy', 'price_1HaJMbHP1DTF1I43FfH8ggSc'], stripe_product_id: 'prod_IAef4KooN6aJVu' },
#   { project: 'Eppendorf', roomtype: 'Premium', prices: ['price_1HaJMOHP1DTF1I433Uu586au', 'price_1HaJMOHP1DTF1I43C8k426tl', 'price_1HaJMOHP1DTF1I43UhQK5XEN'], stripe_product_id: 'prod_IAefLxdgG8kNak' },
#   { project: 'Eppendorf', roomtype: 'Premium (balcony)', prices: ['price_1HaJMIHP1DTF1I437zxOu6D2', 'price_1HaJMIHP1DTF1I43gtPer569', 'price_1HaJMIHP1DTF1I43Nq8Sa3BA'], stripe_product_id: 'prod_IAefPXNVB8REo5' },
#   { project: 'Eppendorf', roomtype: 'Premium+', prices: ['price_1HaJM3HP1DTF1I43FEBi7IvA', 'price_1HaJM3HP1DTF1I43li1toJ9d', 'price_1HaJM3HP1DTF1I43tjWx4Wf0'], stripe_product_id: 'prod_IAeffBrGuPfa1O' },
#   { project: 'Eppendorf', roomtype: 'Premium+ (balcony)', prices: ['price_1HaJLyHP1DTF1I43oStr9gKm', 'price_1HaJLyHP1DTF1I43ENtFR0Jy', 'price_1HaJLyHP1DTF1I43BWkv8ABp'], stripe_product_id: 'prod_IAefl1FnTRZo9Y' },
#   { project: 'Eppendorf', roomtype: 'Jumbo', prices: ['price_1HaJLWHP1DTF1I43bW26I0ha', 'price_1HaJLWHP1DTF1I430zMJf1jP', 'price_1HaJLWHP1DTF1I43a0j7gnTp'], stripe_product_id: 'prod_IAeeVKMYde1Um6' },
#   { project: 'Eppendorf', roomtype: 'Jumbo (balcony)', prices: ['price_1HaJM8HP1DTF1I43AMZVbzVO', 'price_1HaJM8HP1DTF1I43fREpNS0E', 'price_1HaJM8HP1DTF1I43fDxDDorY'], stripe_product_id: 'prod_IAef6XVY0o34dc' },

#   { project: 'Mühlenkamp', roomtype: 'Mighty', prices: ['price_1HaJN3HP1DTF1I43QYncckmq', 'price_1HaJN3HP1DTF1I43rBV2GhoN', 'price_1HaJN3HP1DTF1I43NtoUdBzx'], stripe_product_id: 'prod_IAegQrzv0NPWS0' },
#   { project: 'Mühlenkamp', roomtype: 'Premium', prices: ['price_1HaJMzHP1DTF1I43VLYn3rID', 'price_1HaJMzHP1DTF1I43gefLsnKf', 'price_1HaJMzHP1DTF1I43oXPuRS9z'], stripe_product_id: 'prod_IAegtOxT2U4AYY' },
#   { project: 'Mühlenkamp', roomtype: 'Premium+', prices: ['price_1HaJMuHP1DTF1I43Do9zRULN', 'price_1HaJMuHP1DTF1I43dYjRJ5Ih', 'price_1HaJMuHP1DTF1I435xpsyM8e'], stripe_product_id: 'prod_IAeg9fdeUSoHTD' },
#   { project: 'Mühlenkamp', roomtype: 'Jumbo', prices: ['price_1HaJMpHP1DTF1I43aW7oMIdb', 'price_1HaJMpHP1DTF1I434FOmRiCT', 'price_1HaJMpHP1DTF1I43aZia8EEE'], stripe_product_id: 'prod_IAegV8aOpqTRX4' },

#   { project: 'St. Pauli', roomtype: 'Mighty', prices: ['price_1HaJLIHP1DTF1I43P1TAE0ZL', 'price_1HaJLIHP1DTF1I43U61w4lAI', 'price_1HaJLIHP1DTF1I43ttKSDZ75'], stripe_product_id: 'prod_IAeeXtMMY1A9pJ' },
#   { project: 'St. Pauli', roomtype: 'Premium', prices: ['price_1HaJLDHP1DTF1I436TXiLocM', 'price_1HaJLDHP1DTF1I4318NLgn9l', 'price_1HaJLDHP1DTF1I43Y9V4vr76'], stripe_product_id: 'prod_IAeeQG5bMwgR5V' },
#   { project: 'St. Pauli', roomtype: 'Premium+', prices: ['price_1HaJKqHP1DTF1I43X6fGW1BD', 'price_1HaJKqHP1DTF1I43hZEiM29k', 'price_1HaJKqHP1DTF1I43TdNUu74n'], stripe_product_id: 'prod_IAeeDWGvOjtb1Z' },
#   { project: 'St. Pauli', roomtype: 'Jumbo', prices: ['price_1HaJbGHP1DTF1I43uNtRCrOp', 'price_1HaJbGHP1DTF1I43eFbKz5iE', 'price_1HaJbGHP1DTF1I43tmXeBxjQ'], stripe_product_id: 'prod_IAevx4HTYuKO2j' }
# ]


# stripe.each do |stripe_hash|
#   project = Project.find_by(name: stripe_hash[:project])
#   roomtype = project.roomtypes.find_by(name: stripe_hash[:roomtype])
#   roomtype.update(stripe_product_id: stripe_hash[:stripe_product_id])
# end
  # roomtype.prices.find_by(duration: '3-5 Months').update(stripe_plan_id: stripe_hash[:prices].first)
  # roomtype.prices.find_by(duration: '6-8 Months').update(stripe_plan_id: stripe_hash[:prices].second)
  # roomtype.prices.find_by(duration: '9+ Months').update(stripe_plan_id: stripe_hash[:prices].last)

# bookings = [
#   {room_number: 'D08', full_name: 'Bernardo San Juan', email: 'bsanjuan.consulting@googlemail.com', move_in: '01.09.2020', move_out: '31.10.2020'},
#   {room_number: 'D43', full_name: 'Deniz Aksoy', email: 'd.aksoy@gmx.net', move_in: '01.10.2020', move_out: '31.01.2021'},
#   {room_number: 'D07', full_name: 'Daniel Nicolae Obersterescu', email: 'cristian.obersterescu@gmail.com', move_in: '15.09.2019', move_out: '31.01.2021'},
#   {room_number: 'D09', full_name: 'Candido Castillo', email: 'candidodomingocastillo@gmail.com', move_in: '04.10.2020', move_out: '30.09.2021'},
#   {room_number: 'D16', full_name: 'Carolin Stahl', email: 'carolin.stahl@aol.de', move_in: '04.06.2020', move_out: '31.10.2020'},
#   {room_number: 'D31', full_name: 'Cecan Cakar', email: 'cecan1@web.de', move_in: '22.08.2020', move_out: '30.09.2020'},
#   {room_number: 'D05', full_name: 'Amelie Lessmann', email: 'amelielessmann26@gmail.com', move_in: '01.09.2020', move_out: '30.09.2020'},
#   {room_number: 'D25', full_name: 'Tieme Schardam', email: 'schardamtieme@gmail.com', move_in: '04.09.2020', move_out: '31.01.2021'},
#   {room_number: 'D05', full_name: 'Saad El Hajjaji', email: 'saadelha@gmail.com', move_in: '14.09.2020', move_out: '14.01.2021'},
#   {room_number: 'D31', full_name: 'Theo Pernot', email: 'pernot.theo@outlook.fr', move_in: '01.10.2020', move_out: '14.01.2021'},
#   {room_number: 'D20', full_name: 'Nikolai Siekmann', email: 'nikolai.siekmann@gmail.com', move_in: '01.07.2020', move_out: '30.06.2021'},
#   {room_number: 'D18', full_name: 'Melina Badde', email: 'melina.badde@whu.edu', move_in: '10.06.2020', move_out: '30.09.2020'},
#   {room_number: 'EW15', full_name: 'Francesca Solagna', email: 'f.solagna@uke.de', move_in: '21.09.2020', move_out: '05.01.2021'},
#   {room_number: 'EW12', full_name: 'Jan Dobinsky', email: 'jan.dobinsky@gmail.com', move_in: '01.10.2020', move_out: '14.01.2021'},
#   {room_number: 'EW16', full_name: 'Wanjiru Chabeda', email: 'wanjiru.chabeda@gmail.com', move_in: '15.10.2020', move_out: '31.01.2021'},
#   {room_number: 'EW03', full_name: 'Corinna Thölke', email: 'corinna.thoelke@gmail.com', move_in: '13.06.2020', move_out: '14.12.2020'},
#   {room_number: 'EW10', full_name: 'Robin Wolter', email: 'robinmwolter@gmail.com', move_in: '01.08.2020', move_out: '31.01.2021'},
#   {room_number: 'EW05', full_name: 'Katrin Klütsch', email: 'kat.kluetsch@gmail.com', move_in: '01.07.2020', move_out: '14.12.2020'},
#   {room_number: 'EW13', full_name: 'Emma Widmer', email: 'emma.widmer@uzh.ch', move_in: '01.10.2020', move_out: '28.02.2021'},
#   {room_number: 'EW06', full_name: 'Moritz Stephan', email: 'moritz.stephan@outlook.de', move_in: '12.10.2020', move_out: '14.01.2021'},
#   {room_number: 'EW06', full_name: "Laura Dell'Antonio", email: 'laura@dellantonio.de', move_in: '15.09.2020', move_out: '05.01.2021'}
# ]


#   {room_number: 'EW18', full_name: 'Nick Finckenstein', email: '', move_in: '15.10.2020', move_out: '14.01.2021'},
# #   {room_number: 'D01', full_name: 'Anna Weirauch', email: 'team@stacey-living.de', move_in: '01.10.2019', move_out: '31.03.2020'},
# #   {room_number: 'D01', full_name: 'Carolin Helena Klaus', email: 'carolin_klaus@outlook.de',  move_in: '31.03.2020', move_out: '01.09.2020'},
# #   {room_number: 'D01', full_name: 'Lina Drozd', email: 'linadrozd5@gmail.com',  move_in: '02.09.2020', move_out: '05.01.2021'}
# #   {room_number: 'D02', full_name: 'Andreas Janz', email: 'andreas.janz@gmail.com',  move_in: '24.03.2020', move_out: '30.09.2020'},
# #   {room_number: 'D02', full_name: 'Chloe Bernard', email: 'chloe.bernard8@gmail.com',  move_in: '01.10.2020', move_out: '05.01.2021'},
# #   {room_number: 'D03', full_name: 'Clarissa Leu', email: 'clacoleu@aol.com',  move_in: '05.08.2019', move_out: '05.03.2020'},
# #   {room_number: 'D03', full_name: 'Anatasia Nefed', email: 'anastasianefed@gmail.com',  move_in: '14.03.2020', move_out: '13.07.2020'},
# #   {room_number: 'D03', full_name: 'Lance Williams', email: 'lance.kem.williams@gmail.com',  move_in: '29.07.2020', move_out: '31.10.2020'},
# #   {room_number: 'D04', full_name: 'Melanie Schaub', email: 'schaub.melanie@gmail.com',  move_in: '28.07.2019', move_out: '27.01.2021'},
# #   {room_number: 'D05', full_name: 'Rene Navrkal', email: 'renenavrkal@gmail.com', move_in: '31.08.2019', move_out: '05.05.2020'},
# #   {room_number: 'D05', full_name: 'Mark Veldkamp', email: 'mark_veldkamp@hotmail.nl',  move_in: '15.05.2020', move_out: '23.08.2020'},
# #   {room_number: 'D05', full_name: 'Francesco Lo Piccolo', email: 'frlpiccolo@gmail.com',  move_in: '26.08.2020', move_out: '31.08.2020'},
# #   {room_number: 'D05', full_name: 'Amelie Lessmann', email: 'amelielessmann26@gmail.com',  move_in: '01.09.2020', move_out: '30.09.2021'},
# #   {room_number: 'D06', full_name: 'Christian Ritterbach', email: 'ch.ritterbach@t-online.de', move_in: '01.12.2019', move_out: '31.05.2020'},
# #   {room_number: 'D06', full_name: 'Alyssa Eybächer', email: 'alyssa.eybaecher@gmail.com',  move_in: '02.07.2020', move_out: '30.09.2021'},
# #   {room_number: 'D07', full_name: 'Cristian Obersterescu', email: 'cristian.obersterescu@gmail.com', move_in: '31.07.2019', move_out: '30.01.2021'},
# #   {room_number: 'D08', full_name: 'Julian Müller', email: 'jn.f.mueller@gmail.com',  move_in: '01.09.2019', move_out: '31.08.2020'},
# #   {room_number: 'D08', full_name: 'Bernardo San Juan', email: 'bsanjuan.consulting@googlemail.com',  move_in: '01.09.2020', move_out: '31.10.2020'},
# #   {room_number: 'D09', full_name: 'Sheila Grace Tan', email: 'sheilagracetan@gmail.com',  move_in: '26.07.2019', move_out: '25.12.2019'},
# #   {room_number: 'D09', full_name: 'Candido Castillo', email: 'candidodomingocastillo@gmail.com',  move_in: '04.10.2019', move_out: '03.09.2020'},
# #   {room_number: 'D10', full_name: 'Antonia Rudolf', email: 'antoniarudolf@aol.com', move_in: '31.08.2019', move_out: '29.02.2020'},
# #   {room_number: 'D10', full_name: 'Francisco Coutinho', email: 'flgpc@hotmail.com', move_in: '01.03.2020', move_out: '28.02.2021'},
# #   {room_number: 'D11', full_name: 'Jonas Simonsen', email: 'simonsenjonas@aol.de',  move_in: '01.10.2020', move_out: '05.01.2021'},
# #   {room_number: 'D13', full_name: 'Gauriesh Bindra', email: 'gaurieshbindra@gmail.com',  move_in: '02.08.2019', move_out: '26.01.2020'},
# #   {room_number: 'D13', full_name: 'Javier Randez Garbayo', email: 'javier_93_rg@hotmail.com',  move_in: '27.01.2020', move_out: '26.07.2021'},
# #   {room_number: 'D14', full_name: 'Arkaprabha Ray', email: 'arkadeep97@gmail.com',  move_in: '01.09.2019', move_out: '27.01.2020'},
# #   {room_number: 'D14', full_name: 'Anastasia Krieg', email: 'anastasia.krieg@t-online.de', move_in: '02.02.2020', move_out: '01.05.2020'},
# #   {room_number: 'D14', full_name: 'Sophia Schembecker', email: 'sophiaschembecker@web.de',  move_in: '01.05.2020', move_out: '31.10.2020'},
# #   {room_number: 'D15', full_name: 'Ernesto Ruiz Manzano', email: 'ernesto_900_ruiz@hotmail.com',  move_in: '07.09.2019', move_out: '06.01.2020'},
# #   {room_number: 'D15', full_name: 'Gino Lodola', email: 'gino.lodola@hotmail.com', move_in: '30.12.2019', move_out: '31.08.2020'},
# #   {room_number: 'D15', full_name: 'Simon Hoese', email: 'simonhoese@gmx.de', move_in: '01.09.2020', move_out: '30.11.2020'},
# #   {room_number: 'D16', full_name: 'Kyley Rosser', email: 'kyleyrosser99@gmail.com', move_in: '07.10.2019', move_out: '06.06.2020'},
# #   {room_number: 'D16', full_name: 'Carolin Stahl', email: 'carolin.stahl@aol.de',  move_in: '04.06.2020', move_out: '30.09.2020'},
# #   {room_number: 'D17', full_name: 'Andrea Cianfarani', email: 'andrea.cianfarani@hotmail.com', move_in: '04.10.2019', move_out: '03.04.2020'},
# #   {room_number: 'D17', full_name: 'Charles Herbert', email: 'c.herbert04@gmail.com', move_in: '03.04.2020', move_out: '21.08.2020'},
# #   {room_number: 'D18', full_name: 'Johannes Benthaus', email: 'johannes.benthaus@gmail.com', move_in: '04.10.2019', move_out: '03.01.2020'},
# #   {room_number: 'D18', full_name: 'Vanessa Elana Kröger', email: 'miss.kroeger@web.de', move_in: '04.01.2020', move_out: '04.07.2020'},
# #   {room_number: 'D18', full_name: 'Melina Badde', email: 'melina.badde@whu.edu', move_in: '10.06.2020', move_out: '30.09.2020'},
# #   {room_number: 'D18', full_name: 'Anastasia Bain', email: 'afbainey@aol.com', move_in: '01.10.2020', move_out: '04.10.2021'},
# #   {room_number: 'D19', full_name: 'Tobias Lössl', email: 'tobiloessl@hotmail.de', move_in: '03.10.2019', move_out: '05.01.2020'},
# #   {room_number: 'D19', full_name: 'Pierre Guillaume', email: 'pierre.g.27@live.fr', move_in: '06.01.2020', move_out: '16.05.2020'},
# #   {room_number: 'D20', full_name: 'Matteo Angione', email: 'angionem6@gmail.com', move_in: '03.10.2019', move_out: '02.01.2020'},
# #   {room_number: 'D20', full_name: 'Joachim Bizot', email: 'joachim.bizot@outlook.fr',  move_in: '07.01.2020', move_out: '06.07.2020'},
# #   {room_number: 'D20', full_name: 'Nikolai Siekmann', email: 'nikolai.siekmann@gmail.com',  move_in: '01.07.2020', move_out: '31.10.2020'},
# #   {room_number: 'D21', full_name: 'David Höhl', email: 'david.hoehl@aol.com', move_in: '04.11.2019', move_out: '30.06.2020'},
# #   {room_number: 'D21', full_name: 'Shubham Sharma', email: 'sharmashubham10@gmail.com', move_in: '29.06.2020', move_out: '28.08.2020'},
# #   {room_number: 'D21', full_name: 'Victor Haas', email: 'victor.haas67@gmail.com', move_in: '29.08.2020', move_out: '30.11.2020'},
# #   {room_number: 'D22', full_name: 'Nil Biosca Jimenez', email: 'nbiosca2q@gmail.com', move_in: '06.11.2019', move_out: '31.03.2020'},
# #   {room_number: 'D22', full_name: 'Sai Jagtap', email: 'mesaee@gmail.com',  move_in: '18.04.2020', move_out: '17.10.2020'},
# #   {room_number: 'D23', full_name: 'Angelo Arceri', email: 'angeloarceri@live.it',  move_in: '03.10.2019', move_out: '02.04.2020'},
# #   {room_number: 'D23', full_name: 'Riekje Cordes', email: 'riekje.cordes@gmx.de',  move_in: '03.04.2020', move_out: '31.07.2020'},
# #   {room_number: 'D23', full_name: 'Bernardo San Juan', email: 'bsanjuan.consulting@googlemail.com', move_in: '01.08.2020', move_out: '31.08.2020'},
# #   {room_number: 'D23', full_name: 'Francesco Lo Piccolo', email: 'frlpiccolo@gmail.com',  move_in: '01.09.2020', move_out: '30.11.2020'},
# #   {room_number: 'D24', full_name: 'Victoria Areli Bracamontes Vazquez', email: 'vbracamontes.bss@gmail.com', move_in: '04.11.2019', move_out: '03.08.2021'},
# #   {room_number: 'D25', full_name: 'Ferris Dalle-Grave', email: 'b.dalle-grave@rieckermann.com',  move_in: '05.06.2020', move_out: '04.09.2020'},
# #   {room_number: 'D26', full_name: 'Marcel Franke', email: 'marcel.edmund.franke@gmail.com', move_in: '01.06.2020', move_out: '30.09.2020'},
# #   {room_number: 'D26', full_name: 'Michael Klein', email: 'michael.klein.contact@gmail.com', move_in: '01.10.2020', move_out: '31.03.2021'},
# #   {room_number: 'D27', full_name: 'Pohl Timotheus', email: 'timotheus.pohlt5@gmail.com', move_in: '27.07.2020', move_out: '31.10.2020'},
# #   {room_number: 'D28', full_name: 'Malte Schülein', email: 'mcschuelein@gmail.com', move_in: '01.08.2020', move_out: '31.10.2020'},
# #   {room_number: 'D30', full_name: 'Felix Chemnitzer', email: 'f.chemnitzer@gmail.com',  move_in: '27.06.2020', move_out: '05.01.2021'},
# #   {room_number: 'D31', full_name: 'Cecan Cakar', email: 'cecan1@web.de', move_in: '22.08.2020', move_out: '30.11.2020'},
# #   {room_number: 'D32', full_name: 'Maximilian Busch', email: 'mpbusch01@gmail.com', move_in: '01.08.2020', move_out: '31.10.2020'},
# #   {room_number: 'D33', full_name: 'Eva-Maria Phieler', email: 'evamariaphieler@gmail.com', move_in: '01.08.2020', move_out: '31.10.2020'},
# #   {room_number: 'D34', full_name: 'Charlotte Droste', email: 'charlotte.antonia.droste@gmail.com',  move_in: '01.09.2020', move_out: '05.01.2021'},
# #   {room_number: 'D35', full_name: 'Elizabeth Lee', email: 'eliz.y.lee@gmail.com', move_in: '22.08.2020', move_out: '30.11.2020'},
# #   {room_number: 'D36', full_name: 'Daniel Ammann', email: 'daniel.j.ammann@gmail.com', move_in: '31.08.2020', move_out: '30.11.2020'},
# #   {room_number: 'D37', full_name: 'Emili Läte', email: 'emililte@gmail.com', move_in: '01.10.2020', move_out: '05.01.2020'},
# #   {room_number: 'D39', full_name: 'Simao Bareto', email: 'simaofbarreto@gmail.com', move_in: '15.09.2020', move_out: '14.12.2020'},
# #   {room_number: 'D43', full_name: 'Deniz Aksoy', email: 'd.aksoy@gmx.net', move_in: '01.10.2020', move_out: '31.01.2021'},
# #   {room_number: 'DB01', full_name: 'Sara Isla Cainzos', email: 'saraislac@gmail.com', move_in: '29.02.2020', move_out: '29.11.2020'},
# #   {room_number: 'DB02', full_name: 'Melina Badde', email: 'melina.badde@whu.edu', move_in: '10.06.2020', move_out: '05.07.2020'},
# #   {room_number: 'DB02', full_name: 'Fernando Hoppen', email: 'fehoppen@hotmail.com',  move_in: '01.08.2020', move_out: '31.07.2021'},
# #   {room_number: 'DB03', full_name: 'Friedrich Gottfried Finken', email: 'friedrichfinken@icloud.com', move_in: '01.09.2020', move_out: '30.11.2020'},
# #   {room_number: 'DB04', full_name: 'Amelie Hartig', email: 'amelie.hartig@hotmail.de', move_in: '29.02.2020', move_out: '30.05.2020'},
# #   {room_number: 'DB05', full_name: 'Joseph Cordonnier', email: 'joseph.cordonnier.mdg@gmail.com', move_in: '01.05.2020', move_out: '01.03.2021'},
# #   {room_number: 'DB06', full_name: 'Mehdi Dhifallah', email: 'mehdidhifallah2789@gmail.com',  move_in: '23.03.2020', move_out: '30.10.2020'},
# #   {room_number: 'DB06', full_name: 'Chirag Ahuja', email: 'chiragvit@gmail.com', move_in: '01.11.2020', move_out: '31.01.2021'},
# #   {room_number: 'DB07', full_name: 'Rene Navrkal', email: 'renenavrkal@gmail.com', move_in: '06.05.2020', move_out: '30.06.2020'},
# #   {room_number: 'DB07', full_name: 'Philipp Kramberg', email: 'philipp@kramberg.de', move_in: '28.08.2020', move_out: '30.08.2021'},
# #   {room_number: 'EW02', full_name: 'Moritz Stephan', email: 'moritz.stephan@outlook.de', move_in: '12.10.2020', move_out: '31.07.2020'},
# #   {room_number: 'EW02', full_name: 'Lara Wellner', email: 'lara.wellner@gmail.com', move_in: '11.07.2020', move_out: '11.10.2020'},
# #   {room_number: 'EW03', full_name: 'Anna Loren Stuhr', email: 'annaloren.stuhr@googlemail.com', move_in: '07.07.2020', move_out: '15.07.2021'},
# #   {room_number: 'EW04', full_name: 'Rene Navrkal', email: 'renenavrkal@gmail.com', move_in: '01.07.2020', move_out: '31.08.2020'},
# #   {room_number: 'EW04', full_name: 'Daria Xue', email: 'dariaxue@gmail.com', move_in: '01.09.2020', move_out: '14.07.2021'},
# #   {room_number: 'EW05', full_name: 'Kateryna Dib', email: 'kateryna.dib@gmail.com', move_in: '04.10.2020', move_out: '05.01.2021'},
# #   {room_number: 'EW06', full_name: 'Olina Karlsdottir', email: 'olina.ann@hotmail.com', move_in: '11.06.2020', move_out: '24.10.2020'},
# #   {room_number: 'EW07', full_name: 'Corinna Thölke', email: 'corinna.thoelke@gmail.com', move_in: '13.06.2020', move_out: '20.09.2020'},
# #   {room_number: 'EW07', full_name: 'Francesca Solagna', email: 'f.solagna@uke.de', move_in: '21.09.2020', move_out: '05.01.2021'},
# #   {room_number: 'EW08', full_name: 'Jan Niclas Lietzow', email: 'niclas.lietzow@outlook.com',  move_in: '14.06.2020', move_out: '16.09.2020'},
# #   {room_number: 'EW08', full_name: 'Tom Rose', email: 'tomrose1998@hotmail.co.uk', move_in: '17.09.2020', move_out: '14.01.2021'},
# #   {room_number: 'EW09', full_name: 'Antonia Zeilinger', email: 'antonia_zeilinger@hotmail.com', move_in: '01.08.2020', move_out: '31.01.2021'},
# #   {room_number: 'EW10', full_name: 'Robin Wolter', email: 'robinmwolter@gmail.com', move_in: '01.08.2020', move_out: '31.10.2020'},
# #   {room_number: 'EW11', full_name: 'Leopold Harro Gottfried von Frenckell', email: 'leopoldvf@icloud.com',  move_in: '01.08.2020', move_out: '14.11.2020'},
# #   {room_number: 'EW14', full_name: 'Emma Widmer', email: 'emma.widmer@uzh.ch', move_in: '01.10.2020', move_out: '28.02.2021 '},
# #   {room_number: 'EW16', full_name: 'Nicolas Claudet', email: 'nico.claudet@icloud.com', move_in: '01.10.2020', move_out: '14.07.2021'}
# #   {room_number: 'D11', first_name: 'Dominik', last_name: 'Moskalik', email: 'dmoskalik@web.de', gender: 'Male', phone_code: '+49', phone_number: '017630186268', move_in: '31.08.2019', move_out: '30.09.2020'},
# #   {room_number: 'D12', first_name: 'Christoph', last_name: 'Häberlin', email: 'christoph.haeberlin@gmail.com', gender: 'Male', phone_code: '+49', phone_number: '017645977306', move_in: '27.07.2019', move_out: '26.01.2021'},
# #   {room_number: 'D19', first_name: 'Ivonne', last_name: 'Greulich', email: 'ivonnegreulich@gmail.com', gender: 'Female', phone_code: '+49', phone_number: '000000000000', move_in: '01.05.2020', move_out: '31.10.2020'},
# #   {room_number: 'EW05', first_name: 'Alexandra', last_name: 'Martitz', email: 'alexandra.martitz@online.de', gender: 'Female', phone_code: '+49', phone_number: '000000000000', move_in: '15.06.2020', move_out: '03.10.2020'}
# ]

# # puts('destroy all Projects')
# # Project.destroy_all

# # NOT_FOUND_USERS = []
# # NOT_FOUND_ROOMS = []
# # NOT_FOUND_BOOKINGS = []

# # def find_users_by_email_or_name(email, full_name)
# #   User.select{|u| u.full_name == full_name || u.email == email}
# # end

# # not_found_users = []
# # bookings.each do |booking_hash|
# #   if find_users_by_email_or_name(booking_hash[:email], booking_hash[:full_name]).length == 0
# #     not_found_users << booking_hash[:full_name]
# #   end
# # end

# # def update_current_tenants(bookings_array)
# #   bookings_array.each do |booking_attributes|
# #     u = find_users_by_email_or_name(booking_attributes[:email], booking_attributes[:full_name]).first
# #     if u
# #       booking = u.bookings.last.present? ? u.bookings.last : u.bookings.new
# #       if booking
# #         if !Room.find_by(intern_number: booking_attributes[:room_number]).present?
# #           NOT_FOUND_ROOMS << booking_attributes[:room_number]
# #         end
# #         booking.room_id = Room.find_by(intern_number: booking_attributes[:room_number]).id
# #         booking.move_in = Date.parse(booking_attributes[:move_in])
# #         booking.move_out = Date.parse(booking_attributes[:move_out])
# #         booking.state = 'booked'
# #         booking.save!(validate: false)
# #         u.role = 'tenant'
# #         u.save!(validate: false)
# #       else
# #         NOT_FOUND_BOOKINGS << booking_attributes[:full_name]
# #       end
# #     else
# #       NOT_FOUND_USERS << booking_attributes[:full_name]
# #     end
# #   end
# # end

# # def handle_string_io_as_file(io)
# #   return io unless io.class == StringIO

# #   file = Tempfile.new(["temp",".png"], encoding: 'ascii-8bit')
# #   file.binmode
# #   file.write io.read
# #   file.open
# # end

# # def attach_photos(photos_hash)
# #   photos_hash.each do |photos_hash|
# #     project = Project.find_by(name: photos_hash[:name])
# #     community_area = project.community_areas.last
# #     photos_hash[:community_area].each_with_index do |file, idx|
# #       community_area.photos.attach(io: file, filename: "#{community_area.name} #{idx+1}", content_type: 'image/jpg')
# #       community_area.save
# #     end
# #     photos_hash[:rooms].each do |roomphoto_hash|
# #       roomtype = project.roomtypes.find_by(name: roomphoto_hash[:name])
# #       roomphoto_hash[:photos].each_with_index do |file, idx|
# #         roomtype.photos.attach(io: file, filename: "#{roomtype.name} #{idx+1}", content_type: 'image/jpg')
# #         roomtype.save
# #       end
# #     end
# #   end
# # end

# # def create_descriptions(description_hash)
# #   description_hash.each do |roomtype_names_array, description_content|
# #     all_roomtypes_with_names_included_in_array = Roomtype.select{|rt| roomtype_names_array.include?(rt.name)}
# #     all_roomtypes_with_names_included_in_array.each{|rt| rt.descriptions.create!(field: "#{rt.name} description", content: description_content)}
# #   end
# # end

# # def create_projects_and_attributes(projects_array)
# #   projects_array.each do |project_hash|
# #     project = Project.create!(name: project_hash[:name], status: project_hash[:status])
# #     project_hash[:descriptions].each do |description_hash|
# #       project.descriptions.create(field: description_hash[:field], content: description_hash[:content])
# #     end
# #     address = project.create_address(
# #       street: project_hash[:address][:street],
# #       number: project_hash[:address][:number],
# #       city: project_hash[:address][:city],
# #       zip: project_hash[:address][:zip],
# #       country: project_hash[:address][:country],
# #     )
# #     address.create_description(
# #       field: project_hash[:address][:description][:field],
# #       content: project_hash[:address][:description][:content]
# #     )
# #     community_area = project.community_areas.create(
# #       name: project_hash[:community_area][:name],
# #       size: project_hash[:community_area][:size]
# #     )
# #     community_area.descriptions.create!(
# #       field: project_hash[:community_area][:description][:field],
# #       content: project_hash[:community_area][:description][:content]
# #     )
# #     project_hash[:roomtypes].each do |roomtype_hash|
# #       roomtype = project.roomtypes.create!(
# #         name: roomtype_hash[:name],
# #         size: roomtype_hash[:size]
# #       )
# #       roomtype_hash[:prices].each do |prices_hash|
# #         roomtype.prices.create!(
# #           duration: prices_hash[:duration],
# #           amount: prices_hash[:amount]
# #         )
# #       end
# #       roomtype_hash[:rooms].each do |rooms_hash|
# #         roomtype.rooms.create!(
# #           intern_number: rooms_hash[:intern_number],
# #           house_number: rooms_hash[:house_number],
# #           apartment_number: rooms_hash[:apartment_number],
# #           state: rooms_hash[:state]
# #         )
# #       end
# #     end
# #   end
# # end


# # projects = [
# #   {
# #     name: 'Mühlenkamp',
# #     status: 'active',
# #     descriptions: [
# #       {
# #         field: 'project info index', content: 'A beautiful neighborhood in central Hamburg; everything is here. Find local shops, restaurants and bars nearby. Our community in Mühlenkamp is just as energetic as the neighborhood.'
# #       },
# #       {
# #         field: 'project info show', content: "At STACEY we believe that beautifully designed spaces bring people together. Whether you’re looking to mingle with new people, get creative in the kitchen or open yourself up to new experiences, our Mühlenkamp location can give you all this and more.\nFrom the great living room and the shared kitchen to our beautiful inner yard with a barbecue, your passion points will be catered for. Not to mention the included monthly member events!"
# #       }
# #     ],
# #     address: {
# #       street: 'Dorotheenstraße',
# #       number: '3',
# #       city: 'Hamburg',
# #       zip: '22301',
# #       country: 'Germany',
# #       description: {
# #         field: 'address info',
# #         content: 'Hello, we are STACEY and this is our Co-Living Location in Winterhude. Those who are at home in the trendy Winterhude can enjoy the closeness to the city and the Alster at the same time. Hamburgs central lake is less than a minute away and cafes, restaurants & bars can be found in the neighboring street. Our Mühlenkamp location is the perfect mix for meeting new people outside the location and having the comfort of a quieter neighborhood at the same time.'
# #       }
# #     },
# #     community_area: {
# #       name: "common space Mühlenkamp",
# #       size: 180,
# #       description: {
# #         field: 'common space description',
# #         content: "At STACEY we believe in sharing living spaces to achieve a higher member satisfaction. This is why our Mühlenkamp location offers the biggest common area of all STACEY locations. Enjoy a dinner with your friends in our spacious dining areas or cook in one of the multiple community kitchens. Most importantly, in all our common spaces Netflix is pre-installed. Moreover, next to the dining area and lounge area, the Mühlenkamp location delights through a separated Co-Working space and an outdoor gym. Yes, you read it right - an outdoor gym!"
# #       }
# #     },
# #     roomtypes: [
# #       {
# #         name: 'Mighty',
# #         size: 8,
# #         prices: [
# #           {duration: '3-5 Months', amount: 745},
# #           {duration: '6-8 Months', amount: 695},
# #           {duration: '9+ Months', amount: 645}
# #         ],
# #         rooms: [
# #           { intern_number: "D05", house_number: "3b 1st floor right", apartment_number: '02', state: 'bookable' },
# #           { intern_number: "D07", house_number: "3b 2nd floor right", apartment_number: '03', state: 'bookable' },
# #           { intern_number: "D09", house_number: "3b 2nd floor left", apartment_number: '04', state: 'bookable' },
# #           { intern_number: "D10", house_number: "3 ground floor left", apartment_number: '05', state: 'bookable' },
# #           { intern_number: "D11", house_number: "3 ground floor left", apartment_number: '05', state: 'bookable' },
# #           { intern_number: "D13", house_number: "3 ground floor right", apartment_number: '06', state: 'bookable' },
# #           { intern_number: "D14", house_number: "3 ground floor right", apartment_number: '06', state: 'bookable' },
# #           { intern_number: "D16", house_number: "5 1st floor right", apartment_number: '07', state: 'bookable' },
# #           { intern_number: "D19", house_number: "5 2nd floor left", apartment_number: '08', state: 'bookable' },
# #           { intern_number: "D22", house_number: "3 2nd floor left", apartment_number: '09', state: 'bookable' },
# #           { intern_number: "D25", house_number: "5 ground floor left", apartment_number: '10', state: 'bookable' },
# #           { intern_number: "D27", house_number: "5 ground floor left", apartment_number: '10', state: 'bookable' },
# #           { intern_number: "D28", house_number: "5 ground floor left", apartment_number: '10', state: 'bookable' },
# #           { intern_number: "D29", house_number: "5a 2nd floor left", apartment_number: '11', state: 'bookable' },
# #           { intern_number: "D31", house_number: "5a 1st floor right", apartment_number: '12', state: 'bookable' },
# #           { intern_number: "D32", house_number: "5a 1st floor right", apartment_number: '12', state: 'bookable' },
# #           { intern_number: "D34", house_number: "5a 2nd floor right", apartment_number: '13', state: 'bookable' },
# #           { intern_number: "D35", house_number: "3a 2nd floor right", apartment_number: '13', state: 'bookable' },
# #           { intern_number: "D37", house_number: "3a 1st floor left", apartment_number: '14', state: 'not bookable' },
# #           { intern_number: "D38", house_number: "3a 1st floor left", apartment_number: '14', state: 'not bookable' },

# #           { intern_number: "D40", house_number: "3a ground floor left", apartment_number: '15', state: 'not bookable' },
# #           { intern_number: "D41", house_number: "3a ground floor left", apartment_number: '15', state: 'not bookable' },
# #           { intern_number: "D44", house_number: "3c 1st floor left", apartment_number: '16', state: 'not bookable' },
# #           { intern_number: "D46", house_number: "3c 1st floor left", apartment_number: '17', state: 'not bookable' },
# #           { intern_number: "D48", house_number: "3b ground floor right", apartment_number: '18', state: 'not bookable' },
# #           { intern_number: "D50", house_number: "5a ground floor right", apartment_number: '19', state: 'not bookable' },
# #           { intern_number: "D51", house_number: "5a ground floor right", apartment_number: '19', state: 'not bookable' }
# #           { intern_number: "D53", house_number: "3b 1st floor left", apartment_number: '20', state: 'not bookable' } # new
# #         ]
# #       },
# #       {
# #         name: 'Premium',
# #         size: 13,
# #         prices: [
# #           {duration: '3-5 Months', amount: 845},
# #           {duration: '6-8 Months', amount: 795},
# #           {duration: '9+ Months', amount: 745}
# #         ],
# #         rooms: [
# #           { intern_number: "D01", house_number: "3d 2nd floor", apartment_number: '01', state: 'bookable' },
# #           { intern_number: "D02", house_number: "3d 2nd floor", apartment_number: '01', state: 'bookable' },
# #           { intern_number: "D03", house_number: "3d 2nd floor", apartment_number: '01', state: 'bookable' },
# #           { intern_number: "D17", house_number: "5 1st floor right", apartment_number: '07', state: 'bookable' },
# #           { intern_number: "D20", house_number: "5 2nd floor left", apartment_number: '08', state: 'bookable' },
# #           { intern_number: "D23", house_number: "3 2nd floor left", apartment_number: '09', state: 'bookable' }
# #         ]
# #       },
# #       {
# #         name: 'Premium+',
# #         size: 15,
# #         prices: [
# #           {duration: '3-5 Months', amount: 895},
# #           {duration: '6-8 Months', amount: 845},
# #           {duration: '9+ Months', amount: 795}
# #         ],
# #         rooms: [
# #           { :intern_number => "D12", house_number: "3 ground floor left", apartment_number: '05', state: 'bookable' },
# #           { :intern_number => "D15", house_number: "3 ground floor right", apartment_number: '06', state: 'bookable' },
# #           { :intern_number => "D18", house_number: "5 1st floor right", apartment_number: '07', state: 'bookable' },
# #           { :intern_number => "D21", house_number: "5 2nd floor left", apartment_number: '08', state: 'bookable' },
# #           { :intern_number => "D24", house_number: "3 2nd floor left", apartment_number: '09', state: 'bookable' },
# #           { :intern_number => "D26", house_number: "5 ground floor left", apartment_number: '10', state: 'bookable' },
# #           { :intern_number => "D33", house_number: "5a 1st floor right", apartment_number: '12', state: 'bookable' },
# #           { :intern_number => "D36", house_number: "5a 2nd floor right", apartment_number: '13', state: 'bookable' },
# #           { :intern_number => "D39", house_number: "3a 1st floor left", apartment_number: '14', state: 'not bookable' },
# #           { :intern_number => "D42", house_number: "3a groud floor left", apartment_number: '15', state: 'not bookable' },
# #           { :intern_number => "D49", house_number: "5a groud floor right", apartment_number: '19', state: 'not bookable' }
# #         ]
# #       },
# #       {
# #         name: 'Jumbo',
# #         size: 25,
# #         amount_of_people: 2,
# #         prices: [
# #           {duration: '3-5 Months', amount: 1045},
# #           {duration: '6-8 Months', amount: 995},
# #           {duration: '9+ Months', amount: 945}
# #         ],
# #         rooms: [
# #           { intern_number: "D04", house_number: "3b 1st floor right", apartment_number: '02', state: 'bookable' },
# #           { intern_number: "D06", house_number: "3b 2nd floor right", apartment_number: '03', state: 'bookable' },
# #           { intern_number: "D08", house_number: "3b 2nd floor left", apartment_number: '04', state: 'bookable' },
# #           { intern_number: "D30", house_number: "5a 2nd floor left", apartment_number: '11', state: 'bookable' },
# #           { intern_number: "D43", house_number: "3a 1st floor right", apartment_number: '16', state: 'not bookable' },
# #           { intern_number: "D45", house_number: "3c 1st floor left", apartment_number: '17', state: 'not bookable' },
# #           { intern_number: "D47", house_number: "3c ground floor left", apartment_number: '18', state: 'not bookable' },
# #           { intern_number: "D52", house_number: "3b ground floor left", apartment_number: '20', state: 'not bookable' } #new
# #         ]
# #       }
# #     ]
# #   },
# #   {
# #     name: 'Eppendorf',
# #     status: 'active',
# #     descriptions: [
# #       {
# #         field: 'project info index',
# #         content: 'A beautiful neighborhood in central Hamburg; everything is here. Find local shops, restaurants and bars nearby. Our community in Eppendorf is just as energetic as the neighborhood.'
# #       },
# #       {
# #         field: 'project info show',
# #         content: "At STACEY we believe that beautifully designed spaces bring people together. Whether you’re looking to mingle with new people, get creative in the kitchen or open yourself up to new experiences, our Eppendorf location can give you all this and more.\nFrom the great living room and the shared kitchen to our beautiful inner yard with a barbecue, your passion points will be catered for. Not to mention the included monthly member events!"
# #       }
# #     ],
# #     address: {
# #       street: 'Eppendorfer Weg',
# #       number: '270',
# #       city: 'Hamburg',
# #       zip: '20251',
# #       country: 'Germany',
# #       description: {
# #         field: 'address info',
# #         content: 'Hello, we are STACEY and this is our Co-Living Location in St. Pauli. Those who are at home in the vibrant St. Pauli will enjoy the heart of Hamburg: An adventurous nightlife, Hamburg´s 2nd best football team and an international living experience. STACEY St. Pauli is located between the city and the Hamburg harbour providing access to the real Hamburg experience. Move-in and experience it for yourself!'
# #       }
# #     },
# #     community_area: {
# #       name: "common space Eppendorf",
# #       size: 120,
# #       description: {
# #         field: 'common space description',
# #         content: "The Eppendorf community spaces is our newest edition to the STACEY network. Experience 100m2 of common space in the heart of Eppendorf. The former, completely renovated restaurant, now provides living space for all STACEY members within the location. Our Eppendorf location is our most private Co-Living experience, as it offers the most m2 per member in terms of common spaces. Take a look at the pictures - They speak for themself!"
# #       }
# #     },
# #     roomtypes: [
# #       {
# #         name: 'Mighty',
# #         size: 10,
# #         prices: [
# #           {duration: '3-5 Months', amount: 795},
# #           {duration: '6-8 Months', amount: 745},
# #           {duration: '9+ Months', amount: 695}
# #         ],
# #         rooms: [
# #           { intern_number: "EW04", house_number: "270 2nd floor", apartment_number: '', state: 'bookable' },
# #           { intern_number: "EW06", house_number: "270a 1st floor", apartment_number: '', state: 'bookable' },
# #           { intern_number: "EW09", house_number: "270a 2nd floor", apartment_number: '', state: 'bookable' },
# #           { intern_number: "EW12", house_number: "270a 3rd floor", apartment_number: '', state: 'bookable' },
# #           { intern_number: "EW15", house_number: "270a 3rd floor", apartment_number: '', state: 'bookable' }
# #         ]
# #       },
# #       {
# #         name: 'Mighty+',
# #         size: 10,
# #         prices: [
# #           {duration: '3-5 Months', amount: 895},
# #           {duration: '6-8 Months', amount: 845},
# #           {duration: '9+ Months', amount: 795}
# #         ],
# #         rooms: [
# #           { intern_number: "EW05", house_number: "270", apartment_number: '', state: 'bookable' }
# #         ]
# #       },
# #       {
# #         name: 'Premium',
# #         size: 12,
# #         prices: [
# #           {duration: '3-5 Months', amount: 895},
# #           {duration: '6-8 Months', amount: 745},
# #           {duration: '9+ Months', amount: 795}
# #         ],
# #         rooms: [
# #           { intern_number: "EW08", house_number: "270a 1st floor", apartment_number: '', state: 'bookable' },
# #           { intern_number: "EW11", house_number: "270a 2nd floor", apartment_number: '', state: 'bookable' },
# #           { intern_number: "EW14", house_number: "270a 3rd floor", apartment_number: '', state: 'bookable' },
# #           { intern_number: "EW16", house_number: "270a 3rd floor", apartment_number: '', state: 'bookable' }
# #         ]
# #       },
# #       {
# #         name: 'Premium (balcony)',
# #         size: 12,
# #         prices: [
# #           {duration: '3-5 Months', amount: 995},
# #           {duration: '6-8 Months', amount: 945},
# #           {duration: '9+ Months', amount: 895}
# #         ],
# #         rooms: [
# #           { intern_number: "EW07", house_number: "270a 1st floor", apartment_number: '', state: 'bookable' },
# #           { intern_number: "EW10", house_number: "270a 2nd floor", apartment_number: '', state: 'bookable' },
# #           { intern_number: "EW13", house_number: "270a 3rd floor", apartment_number: '', state: 'bookable' }
# #         ]
# #       },
# #       {
# #         name: 'Premium+',
# #         size: 14,
# #         prices: [
# #           {duration: '3-5 Months', amount: 995},
# #           {duration: '6-8 Months', amount: 945},
# #           {duration: '9+ Months', amount: 895}
# #         ],
# #         rooms: [
# #           { intern_number: "EW01", house_number: "270 2nd floor", apartment_number: '', state: 'bookable' },
# #           { intern_number: "EW17", house_number: "270 3rd floor", apartment_number: '', state: 'bookable' }
# #         ]
# #       },
# #       {
# #         name: 'Premium+ (balcony)',
# #         size: 14,
# #         prices: [
# #           {duration: '3-5 Months', amount: 1_095},
# #           {duration: '6-8 Months', amount: 1_045},
# #           {duration: '9+ Months', amount: 995}
# #         ],
# #         rooms: [
# #           { intern_number: "EW02", house_number: "270 2nd floor", apartment_number: '', state: 'bookable' }
# #         ]
# #       },
# #       {
# #         name: 'Jumbo',
# #         size: 17,
# #         prices: [
# #           {duration: '3-5 Months', amount: 1_095},
# #           {duration: '6-8 Months', amount: 1_045},
# #           {duration: '9+ Months', amount: 995}
# #         ],
# #         rooms: [
# #           { intern_number: "EW03", house_number: "270 2nd floor", apartment_number: '', state: 'bookable' }
# #         ]
# #       },
# #       {
# #         name: 'Jumbo (balcony)',
# #         size: 17,
# #         prices: [
# #           {duration: '3-5 Months', amount: 1_095},
# #           {duration: '6-8 Months', amount: 1_045},
# #           {duration: '9+ Months', amount: 995}
# #         ],
# #         rooms: [
# #           { intern_number: "EW18", house_number: "270 3rd floor", apartment_number: '', state: 'bookable' }
# #         ]
# #       }
# #     ]
# #   },
# #   {
# #     name: 'St. Pauli',
# #     status: 'active',
# #     descriptions: [
# #       {
# #         field: 'project info index',
# #         content: 'A beautiful neighborhood in central Hamburg; everything is here. Find local shops, restaurants and bars nearby. Our community in St. Pauli is just as energetic as the neighborhood.'
# #       },
# #       {
# #         field: 'project info show',
# #         content: "At STACEY we believe that beautifully designed spaces bring people together. Whether you’re looking to mingle with new people, get creative in the kitchen or open yourself up to new experiences, our St. Pauli location can give you all this and more.\nFrom the great living room and the shared kitchen to our beautiful inner yard with a barbecue, your passion points will be catered for. Not to mention the included monthly member events!"
# #       }
# #     ],
# #     address: {
# #       street: 'Detlev-Bremer-Straße',
# #       number: '2',
# #       city: 'Hamburg',
# #       zip: '20359',
# #       country: 'Germany',
# #       description: {
# #         field: 'address info',
# #         content: 'Hello, we are STACEY and this is our Co-Living Location in Eppendorf. Those who are at home in the pretty Eppendorf can count themselves lucky: Lots of water, green, representative architecture and urban quality of life. Chic boutiques, but also small grocery stores supply the residents with luxury goods or everyday needs.'
# #       }
# #     },
# #     community_area: {
# #       name: "common space St. Pauli",
# #       size: 50,
# #       description: {
# #         field: 'common space description',
# #         content: "It might not be the home of the best football team in the world, but it definitely locates an amazing STACEY common area. The St. Pauli common space is  located directly within the apartment, just outside of your own private suite. Besides a fully equipped kitchen, we have a basement to hang out and meet with your cohabitants and friends."
# #       }
# #     },
# #     roomtypes: [
# #       {
# #         name: 'Mighty',
# #         size: 9,
# #         prices: [
# #           {duration: '3-5 Months', amount: 745},
# #           {duration: '6-8 Months', amount: 695},
# #           {duration: '9+ Months', amount: 645}
# #         ],
# #         rooms: [
# #           { intern_number: "DB01", house_number: "2 ground floor", apartment_number: '', state: 'bookable' },
# #           { intern_number: "DB06", house_number: "2 ground floor", apartment_number: '', state: 'bookable' }
# #         ]
# #       },
# #       {
# #         name: 'Premium',
# #         size: 12,
# #         prices: [
# #           {duration: '3-5 Months', amount: 895},
# #           {duration: '6-8 Months', amount: 845},
# #           {duration: '9+ Months', amount: 795}
# #         ],
# #         rooms: [
# #           { intern_number: "DB04", house_number: "2 ground floor", apartment_number: '', state: 'bookable' }
# #         ]
# #       },
# #       {
# #         name: 'Premium+',
# #         size: 14,
# #         prices: [
# #           {duration: '3-5 Months', amount: 995},
# #           {duration: '6-8 Months', amount: 945},
# #           {duration: '9+ Months', amount: 895}
# #         ],
# #         rooms: [
# #           { intern_number: "DB02", house_number: "2 ground floor", apartment_number: '', state: 'bookable' },
# #           { intern_number: "DB05", house_number: "2 ground floor", apartment_number: '', state: 'bookable' }
# #         ]
# #       },
# #       {
# #         name: 'Jumbo',
# #         size: 21,
# #         amount_of_people: 2,
# #         prices: [
# #           {duration: '3-5 Months', amount: 1_095},
# #           {duration: '6-8 Months', amount: 1_045},
# #           {duration: '9+ Months', amount: 995}
# #         ],
# #         rooms: [
# #           { intern_number: "DB03", house_number: "2 ground floor", apartment_number: '', state: 'bookable' },
# #           { intern_number: "DB07", house_number: "2 ground floor", apartment_number: '', state: 'bookable' }
# #         ]
# #       }
# #     ]
# #   }
# # ]

# # puts('create Projects')
# # create_projects_and_attributes(projects)

# # photos = [
# #   {
# #     name: 'Mühlenkamp',
# #     community_area: [
# #       URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305506/Muehlenkamp/Community/JDVGtf5XQKKU04eAbpVGoA_thumb_10e.jpg'),
# #       URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305505/Muehlenkamp/Community/HcSj5Kp6Sdi4XinvCWPd4Q_thumb_dc.jpg'),
# #       URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305502/Muehlenkamp/Community/vFA9JCMcTjWI8OL4SuuIIQ_thumb_a3.jpg'),
# #       URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305498/Muehlenkamp/Community/3NAop8mzQgCjDot3VMQ2Ag_thumb_f4.jpg'),
# #       URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305504/Muehlenkamp/Community/QqTm5JToSZia_LVc7stfGQ_thumb_bf.jpg'),
# #       URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305504/Muehlenkamp/Community/tbEIKPCxTjm3djJAHGx4sg_thumb_bc.jpg'),
# #       URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305502/Muehlenkamp/Community/EIYZB8ivSL_Me7P8eC1JYA_thumb_95.jpg'),
# #       URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305501/Muehlenkamp/Community/b_06CW77RI_4mee8FNt16g_thumb_9b.jpg'),
# #       URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305497/Muehlenkamp/Community/UNADJUSTEDNONRAW_thumb_113.jpg'),
# #       URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305495/Muehlenkamp/Community/UNADJUSTEDNONRAW_thumb_111.jpg'),
# #       URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305494/Muehlenkamp/Community/9DOqWt7fSImACXkALYggQg_thumb_124.jpg'),
# #       URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305495/Muehlenkamp/Community/L_TfMlHdRJCPOtYSZCauTQ_thumb_e8.jpg'),
# #       URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305505/Muehlenkamp/Community/Em_yXaqoSUySsGf6YxR6zA_thumb_e3.jpg')
# #     ],
# #     rooms: [
# #       {
# #         name: 'Mighty',
# #         photos: [
# #           URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305544/Muehlenkamp/Mighty/eAX0adO0SQGx35a9vy7APw_thumb_129.jpg'),
# #           URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305544/Muehlenkamp/Mighty/SDzfpI1bSeu2a3P9kuRgRQ_thumb_133.jpg'),
# #           URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305543/Muehlenkamp/Mighty/uvX94s4HQSumDZUCmEvWgA_thumb_12b.jpg')
# #         ]
# #       },
# #       {
# #         name: 'Premium',
# #         photos: [
# #           URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1591776624/Muehlenkamp/Premium/muehlenkamp_premium_2.jpg'),
# #           URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1591776586/Muehlenkamp/Premium/muehlenkamp_premium_1.jpg')
# #         ]
# #       },
# #       {
# #         name: 'Premium+',
# #         photos: [
# #           URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305564/Muehlenkamp/PremiumPlus/EQXzU0UJRcWW7H8T3nrNMQ_thumb_2a4.jpg'),
# #           URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305564/Muehlenkamp/PremiumPlus/U_f4M1tPRg_aIfntPKkoNw_thumb_2a2.jpg'),
# #           URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305564/Muehlenkamp/PremiumPlus/4puZFG9ESPSGy_hIXnIexw_thumb_2a5.jpg')
# #         ]
# #       },
# #       {
# #         name: 'Jumbo',
# #         photos: [
# #           URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305526/Muehlenkamp/Jumbo/xg8xDsPIQA_50qjnQprtEA_thumb_7d.jpg'),
# #           URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305524/Muehlenkamp/Jumbo/7qBWokpDQF_aLyAKMyYcIA_thumb_8c.jpg'),
# #           URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305522/Muehlenkamp/Jumbo/ELYyajx2Rs6jvE3UMI6_5w_thumb_86.jpg'),
# #           URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305522/Muehlenkamp/Jumbo/gidwWRV5QQqtOtKCA4s0LQ_thumb_7e.jpg'),
# #           URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305520/Muehlenkamp/Jumbo/qEm1_rrbTLuSfKCB_K_V_w_thumb_77.jpg'),
# #           URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305518/Muehlenkamp/Jumbo/WuJcgQ0CQyuBrn4Up1CK7A_thumb_6b.jpg'),
# #           URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305518/Muehlenkamp/Jumbo/qDZes3GUQJezro1NM7Tl0w_thumb_64.jpg')
# #         ]
# #       }
# #     ]
# #   },
# #   {
# #     name: 'Eppendorf',
# #     community_area: [
# #       URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305084/Eppendorf/Community/lIXRCIrxSzalnuxX7onN1A_thumb_162.jpg'),
# #       URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305095/Eppendorf/Community/L7VC3pucSmGuSldp5ZdqJA_thumb_1aa.jpg'),
# #       URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305091/Eppendorf/Community/UNADJUSTEDNONRAW_thumb_18a.jpg'),
# #       URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305090/Eppendorf/Community/FTIjlYPSQZm0OrV8Rdf4tw_thumb_182.jpg'),
# #       URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305043/Eppendorf/Community/Zyn9S_e3TEWs_wUnIuNT5w_thumb_190.jpg'),
# #       URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305043/Eppendorf/Community/829vH1IFTEWAxXeTrL_cEQ_thumb_18e.jpg'),
# #       URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305043/Eppendorf/Community/GrZ83xNZQICs1Pz_hEhMXg_thumb_17b.jpg'),
# #       URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305040/Eppendorf/Community/UwH7caRSQNS_uxb5TnCU2g_thumb_173.jpg'),
# #       URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305086/Eppendorf/Community/uy8xnX42TVq_A3III_YkRA_thumb_169.jpg'),
# #       URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305040/Eppendorf/Community/F1yPZYuuRKOPjl9LZMJVSg_thumb_15c.jpg'),
# #       URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305085/Eppendorf/Community/tp2OFgvZS6uyBLllP7q_fQ_thumb_15f.jpg'),
# #       URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305046/Eppendorf/Community/JN7MfQjRTAKybAA1aX_kVA_thumb_1c3.jpg'),
# #       URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305096/Eppendorf/Community/D3iLLYUSSCQ3Z4ug_9OhA_thumb_1b6.jpg')
# #     ],
# #     rooms: [
# #       {
# #         name: 'Mighty',
# #         photos: [
# #           URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305150/Eppendorf/Mighty/ZZqSpUpLRzyFoNkRUyI6og_thumb_248.jpg'),
# #           URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305150/Eppendorf/Mighty/vuxOG5GERoSmkdBb2S53oQ_thumb_247.jpg'),
# #           URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305150/Eppendorf/Mighty/4ldkRKe0QrGF5q9O634zPw_thumb_241.jpg')
# #         ]
# #       },
# #       {
# #         name: 'Premium',
# #         photos: [
# #           URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305177/Eppendorf/Premium/4GMt5Br5QzOfc9hmldcreA_thumb_226.jpg'),
# #           URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305187/Eppendorf/Premium/LzFIsX6TSru0jnYIht0cMA_thumb_1f3.jpg'),
# #           URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305177/Eppendorf/Premium/Tj8D6dYATLS3hxxspLO_fw_thumb_1db.jpg')
# #         ]
# #       },
# #       {
# #         name: 'Premium+',
# #         photos: [
# #           URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305210/Eppendorf/PremiumPlus/xI0FTJCQNeo_2ZyYcTpsw_thumb_25d.jpg'),
# #           URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305210/Eppendorf/PremiumPlus/BJ6QZ4F6QVGFESoF27pSLg_thumb_25f.jpg'),
# #           URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305209/Eppendorf/PremiumPlus/XCdfKPfQQ_27Tl3gGq1JWQ_thumb_261.jpg'),
# #           URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305209/Eppendorf/PremiumPlus/R6U0JvmhQDiXhPUyi9FAEg_thumb_26b.jpg'),
# #           URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305211/Eppendorf/PremiumPlus/0Im4zgRHTBiqAnIewu2Mvg_thumb_267.jpg')
# #         ]
# #       },
# #       {
# #         name: 'Jumbo',
# #         photos: [
# #           URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305263/Eppendorf/Jumbo/yr7wyFlJQf_KmB9wnplWiA_thumb_274.jpg'),
# #           URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305260/Eppendorf/Jumbo/3OP0NtCCRpSCUA2jf8b9ew_thumb_288.jpg'),
# #           URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305260/Eppendorf/Jumbo/2bKM4_DZQNKYYud8PAcs_A_thumb_27c.jpg'),
# #           URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305260/Eppendorf/Jumbo/YVnUzgDYSdWSd_BQsnqkaA_thumb_28d.jpg'),
# #           URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305260/Eppendorf/Jumbo/mhCiEf1hQjCXcuWE6iQouw_thumb_294.jpg')
# #         ]
# #       }
# #     ]
# #   },
# #   {
# #     name: 'St. Pauli',
# #     community_area: [
# #       URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305752/St.%20Pauli/Community/ix5_os61QP2aiwbnmyTPAQ_thumb_2aa.jpg'),
# #       URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305755/St.%20Pauli/Community/5eh7N_I8R2uiqyjqPKnBjQ_thumb_2a6.jpg'),
# #       URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305761/St.%20Pauli/Community/ruAcCY62RmOSgFeuvUcOWQ_thumb_2a7.jpg'),
# #       URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305752/St.%20Pauli/Community/XNRI5JV4Tz2Z27qBN8gzHQ_thumb_2af.jpg'),
# #       URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305751/St.%20Pauli/Community/G2L6UQLlT_m_AsK2hG4BMQ_thumb_2ad.jpg'),
# #       URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305751/St.%20Pauli/Community/hZ1avSXdSXKWl8cHpHQxOQ_thumb_2a8.jpg'),
# #       URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305751/St.%20Pauli/Community/4CwMSQnaS3OG6nh8o2Kefw_thumb_2a9.jpg')
# #     ],
# #     rooms: [
# #       {
# #         name: 'Mighty',
# #         photos: [
# #           URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305779/St.%20Pauli/Mighty/9sJn0XhXQWSnNlnAY5qiog_thumb_2be.jpg'),
# #           URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305779/St.%20Pauli/Mighty/2JYyffPlSE2PKcvqlIeY9Q_thumb_2bd.jpg')
# #         ]
# #       },
# #       {
# #         name: 'Premium',
# #         photos: [
# #           URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305910/St.%20Pauli/Premium/etyq1jicSISjC2kaGvknKw_thumb_2c3.jpg'),
# #           URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305910/St.%20Pauli/Premium/YhfvXFl3R4KPIlgy36Zvcw_thumb_2bf.jpg'),
# #           URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305910/St.%20Pauli/Premium/7nOOlsH5T2akODDT1PPzBw_thumb_2c2.jpg'),
# #           URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305911/St.%20Pauli/Premium/ruC_Rtm8Sc_hiREJQOo8gA_thumb_2c4.jpg')
# #         ]
# #       },
# #       {
# #         name: 'Premium+',
# #         photos: [
# #           URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305929/St.%20Pauli/PremiumPlus/RFu4xK4rTrmChzc3VoQJlQ_thumb_2c6.jpg'),
# #           URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305929/St.%20Pauli/PremiumPlus/NQQT5lnTS7WCmobDw_R1hA_thumb_2c9.jpg'),
# #           URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305930/St.%20Pauli/PremiumPlus/zfiXMp51Q7eixCq5_P_hKg_thumb_2ca.jpg'),
# #           URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305932/St.%20Pauli/PremiumPlus/LweHuZn8RveZgeF6KBPNlQ_thumb_2cb.jpg')
# #         ]
# #       },
# #       {
# #         name: 'Jumbo',
# #         photos: [
# #           URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305810/St.%20Pauli/Jumbo/w5Fw1W_7RdeJX1rbonPM6w_thumb_2d2.jpg'),
# #           URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305810/St.%20Pauli/Jumbo/9gN4eFdcSM2zk1_e5LQTtg_thumb_2d1.jpg'),
# #           URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305810/St.%20Pauli/Jumbo/NAR5Ke_FRFaRLgChuarwfA_thumb_2ce.jpg'),
# #           URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1592305810/St.%20Pauli/Jumbo/DLqroMiwR8OKHdt8WI9NvQ_thumb_2cd.jpg')
# #         ]
# #       }
# #     ]
# #   }
# # ]

# # puts('Attach Photos')
# # attach_photos(photos)

# # roomtype_descriptions = {
# #   ['Mighty', 'Mighty+'] => "Mighty people need a mighty room with extra space for thoughts, creativity and for the dust to settle… Don't worry, we will take care of the cleaning.",
# #   ['Premium', 'Premium (balcony)'] => "If you love Marie Kondo’s minimalist style and would like to give it a try in a space slightly larger than our Mighty room, then this room is all you need to free yourself from the things that do not spark joy.",
# #   ['Premium+', 'Premium+ (balcony)'] => "Our Premium rooms fit everything you need. However if you do need extra space for your spirit & mind the slightly bigger Premium+ suites will be the best choice!",
# #   ['Jumbo']=> "When has the word “jumbo” ever indicated anything average? Wake up in a world all your own and fill it with all that matters to you. Screw the minimalism and let your maximalist self out of its cage."
# # }

# # puts('Create descriptions for all roomtypes')
# # create_descriptions(roomtype_descriptions)


# # # create Amenities new Photos to do so.
# # if Amenity.count == 0
# #   amenities = {
# #     "wifi" => URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1591606737/wifi.png'),
# #     "smart locks" => URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1591606737/padlock.png'),
# #     "coffee flatrate" => URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1591606737/coffee-cup.png'),
# #     "fully furnished" => URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1591606737/couch.png'),
# #     "work spaces" => URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1591606737/work-space.png'),
# #     "table tennis" => URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1591606737/ping-pong.png'),
# #     "common space" => URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1591606737/meeting.png'),
# #     "weekly cleaning" => URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1591606737/liquid-soap.png'),
# #     "fully equipped kitchen" => URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1591606737/chefs-hat.png'),
# #     "2x fully equipped kitchens" => URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1591606737/chefs-hat.png'),
# #     "lounge space" => URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1591606737/lounge-chair.png'),
# #     "inner yard" => URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1591606737/tree.png'),
# #     "2 people" => URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1591606736/users.png'),
# #     "dining space" => URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1591606736/service.png'),
# #     "laundry room" => URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1591606736/washing-machine.png'),
# #     "1 person" => URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1591606736/user.png'),
# #     "monthly member events" => URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1591608023/calendar.png'),
# #     "welcome gift" => URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1591608023/gift.png'),
# #     "side table" => URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1591608023/side-table.png'),
# #     "wardrobe with hangers and drawers" => URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1591608023/closet.png'),
# #     "artwork" => URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1591608023/artist.png'),
# #     "armchair" => URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1591608024/armchair.png'),
# #     "desk with chair" => URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1591608023/desk.png'),
# #     "bedding" => URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1591608023/pillow.png'),
# #     "double bed" => URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1591608024/bed.png'),
# #     "queensize bed" => URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1591608608/king_size_bed.png'),
# #     "shared bathroom" => URI.open('https://res.cloudinary.com/dvuqwvjay/image/upload/v1594203504/toilet-paper.png')
# #   }

# #   puts('create Amenities')
# #   amenities.each do |title, file|
# #     a = Amenity.new(title: title)
# #     a.photo.attach(io: handle_string_io_as_file(file), filename: "#{title.gsub(' ', '_')}.png", content_type: 'image/png')
# #     a.save
# #   end
# # end

# # update_current_tenants(bookings)
# # puts('not found users')
# # puts(NOT_FOUND_USERS)
# # puts('not found bookings')
# # puts(NOT_FOUND_BOOKINGS)
# # puts('not found rooms')
# # puts(NOT_FOUND_ROOMS)




