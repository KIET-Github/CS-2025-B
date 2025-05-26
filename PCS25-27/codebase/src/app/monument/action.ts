"use server";

import { createClient } from "@/utils/supabase/server";

interface Props {
  date: Date;
  childrens: string;
  adults: string;
  price: number;
  user_id: string;
  monument_name: string; // Added monument name
}

export async function bookTicket(formData: Props) {
  const supabase = createClient();
  const { date, childrens, adults, price, user_id, monument_name } = formData;
  const res = await supabase
    .from("bookings")
    .insert({
      price: price,
      adults: adults,
      childrens: childrens,
      user_id: user_id,
      date_of_visit: date,
      monument_name: monument_name, // Store monument name in the database
    })
    .select();
  return JSON.stringify(res);
}
