"use client";

import * as React from "react";
import { PostgrestSingleResponse } from "@supabase/supabase-js";
import { cn } from "@/lib/utils";
import { CalendarIcon } from "lucide-react";
import { format, set } from "date-fns";
import { useForm } from "react-hook-form";
import * as z from "zod";
import { bookingSchema } from "@/lib/schema";
import { zodResolver } from "@hookform/resolvers/zod";
import { useToast } from "../ui/use-toast";
import { createClient } from "@/utils/supabase/client";
import { ToastAction } from "@radix-ui/react-toast";
import { Calendar } from "@/components/ui/calendar";
import { Button } from "../ui/button";
import {
  Form,
  FormControl,
  FormField,
  FormItem,
  FormLabel,
  FormMessage,
} from "@/components/ui/form";
import {
  Popover,
  PopoverContent,
  PopoverTrigger,
} from "@/components/ui/popover";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import { bookTicket } from "@/app/monument/action";
import { useRouter } from "next/navigation";

interface BookingProps extends React.HTMLAttributes<HTMLDivElement> {
  setOpen: React.Dispatch<React.SetStateAction<boolean>>;
  setBookingID: React.Dispatch<React.SetStateAction<string>>;
  ticketprice: {
    adults: number;
    children: number;
  };
  monumentName: string;
}

type FormData = z.infer<typeof bookingSchema>;

export function BookingForm({
  className,
  ticketprice,
  setOpen,
  setBookingID,
  monumentName, // Added monument name prop
  ...props
}: BookingProps) {
  const { toast } = useToast();
  const [tickets, setTickets] = React.useState({
    children: 0,
    adult: 0,
  });
  //   console.log(parseInt(ticketprice.adults), parseInt(ticketprice.children));
  const router = useRouter();
  const [price, setPrice] = React.useState(0);
  const form = useForm<z.infer<typeof bookingSchema>>({
    resolver: zodResolver(bookingSchema),
  });

  async function onSubmit(data: FormData) {
    try {
      const supabase = createClient();
      const user = await supabase.auth.getUser();
      const user_id = user.data.user?.id || "";
      if (!user_id) {
        router.push("/login");
        router.refresh();
        toast({
          variant: "destructive",
          title: "Uh oh! Something went wrong.",
          action: <ToastAction altText="Try again">Try again</ToastAction>,
        });
      }

      const { childrens, adults, date } = data;
      const res = await bookTicket({
        user_id,
        price,
        childrens,
        adults,
        date,
        monument_name: monumentName,
      });
      form.reset();
      const responseData = await JSON.parse(res);
      console.log(responseData);
      setBookingID(responseData.data[0].id);
      setOpen((prev) => !prev);
      if (res) {
        toast({
          variant: "default",
          title: "Success",
          description: "Ticked Successfully Booked",
        });
      } else {
        toast({
          variant: "destructive",
          title: "Uh oh! Something went wrong.",
          action: <ToastAction altText="Try again">Try again</ToastAction>,
        });
      }
      console.log(res);
    } catch (error) {
      form.reset();
      console.log(error);
    }
  }
  const handleTicketChange = (type: string, value: string) => {
    // Create a new tickets object with the updated value
    const updatedTickets = {
      ...tickets,
      [type]: parseInt(value),
    };

    // Set the tickets state
    setTickets(updatedTickets);

    // Calculate price using the updated ticket values
    const newPrice =
      updatedTickets.adult * ticketprice.adults +
      updatedTickets.children * ticketprice.children;

    setPrice(newPrice);
  };

  return (
    <div className={cn("grid gap-6 p-6", className)} {...props}>
      <Form {...form}>
        <form onSubmit={form.handleSubmit(onSubmit)} className="space-y-8">
          <FormField
            control={form.control}
            name="date"
            render={({ field }) => (
              <FormItem className="flex flex-col">
                <FormLabel>Date of Visit</FormLabel>
                <Popover>
                  <PopoverTrigger asChild>
                    <FormControl>
                      <Button
                        variant={"outline"}
                        className={cn(
                          "w-[240px] pl-3 text-left font-normal",
                          !field.value && "text-muted-foreground"
                        )}
                      >
                        {field.value ? (
                          format(field.value, "PPP")
                        ) : (
                          <span>Pick a date</span>
                        )}
                        <CalendarIcon className="ml-auto h-4 w-4 opacity-50" />
                      </Button>
                    </FormControl>
                  </PopoverTrigger>
                  <PopoverContent className="w-auto p-0" align="start">
                    <Calendar
                      mode="single"
                      selected={field.value}
                      onSelect={field.onChange}
                      disabled={(date) =>
                        date <= new Date() || date <= new Date("1900-01-01")
                      }
                      initialFocus
                    />
                  </PopoverContent>
                </Popover>
                <FormMessage />
              </FormItem>
            )}
          />
          <div className="flex space-x-6 items-center">
            <FormField
              control={form.control}
              name="childrens"
              render={({ field }) => (
                <FormItem>
                  <FormLabel>Childrens</FormLabel>
                  <Select
                    onValueChange={(value) => {
                      handleTicketChange("children", value);
                      field.onChange(value);
                    }}
                    defaultValue={field.value}
                  >
                    <FormControl>
                      <SelectTrigger>
                        <SelectValue placeholder="0" />
                      </SelectTrigger>
                    </FormControl>
                    <SelectContent>
                      <SelectItem value="0">0</SelectItem>
                      <SelectItem value="1">1</SelectItem>
                      <SelectItem value="2">2</SelectItem>
                      <SelectItem value="3">3</SelectItem>
                      <SelectItem value="4">4</SelectItem>
                      <SelectItem value="5">5</SelectItem>
                    </SelectContent>
                  </Select>
                  <FormMessage />
                </FormItem>
              )}
            />
            <FormField
              control={form.control}
              name="adults"
              render={({ field }) => (
                <FormItem>
                  <FormLabel>Adults</FormLabel>
                  <Select
                    onValueChange={(value) => {
                      handleTicketChange("adult", value);
                      field.onChange(value);
                    }}
                    defaultValue={field.value}
                  >
                    <FormControl>
                      <SelectTrigger>
                        <SelectValue placeholder="0" />
                      </SelectTrigger>
                    </FormControl>
                    <SelectContent>
                      <SelectItem value="0">0</SelectItem>
                      <SelectItem value="1">1</SelectItem>
                      <SelectItem value="2">2</SelectItem>
                      <SelectItem value="3">3</SelectItem>
                      <SelectItem value="4">4</SelectItem>
                      <SelectItem value="5">5</SelectItem>
                    </SelectContent>
                  </Select>
                  <FormMessage />
                </FormItem>
              )}
            />
          </div>
          <h3>Total: Rs{price}</h3>
          <Button type="submit">Book now</Button>
        </form>
      </Form>
    </div>
  );
}
