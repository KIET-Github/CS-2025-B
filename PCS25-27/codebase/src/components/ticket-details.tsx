"use client";
import React from "react";
import { format } from "date-fns";
import { Separator } from "@/components/ui/separator";
import { cn } from "@/lib/utils";

interface Booking {
  id: string;
  price: number;
  adults: string;
  childrens: string;
  date_of_visit: string;
  monument_name: string;
  created_at: string;
  is_used?: boolean;
  user_id: string;
}

interface TicketDetailsProps {
  ticket: Booking;
  className?: string;
}

const TicketDetails: React.FC<TicketDetailsProps> = ({ ticket, className }) => {
  return (
    <div className={cn("space-y-3", className)}>
      <div className="grid grid-cols-2 gap-2">
        <div className="text-sm font-medium">Monument:</div>
        <div className="text-sm font-semibold">
          {ticket.monument_name || "Not specified"}
        </div>
      </div>

      <Separator />

      <div className="grid grid-cols-2 gap-2">
        <div className="text-sm font-medium">Date of Visit:</div>
        <div className="text-sm">
          {ticket.date_of_visit
            ? format(new Date(ticket.date_of_visit), "PPP")
            : "Not specified"}
        </div>
      </div>

      <Separator />

      <div className="grid grid-cols-2 gap-2">
        <div className="text-sm font-medium">Adults:</div>
        <div className="text-sm">{ticket.adults}</div>
      </div>

      <div className="grid grid-cols-2 gap-2">
        <div className="text-sm font-medium">Children:</div>
        <div className="text-sm">{ticket.childrens}</div>
      </div>

      <Separator />

      <div className="grid grid-cols-2 gap-2">
        <div className="text-sm font-medium">Ticket Price:</div>
        <div className="text-sm font-semibold">₹{ticket.price}</div>
      </div>

      <div className="grid grid-cols-2 gap-2">
        <div className="text-sm font-medium">Booking ID:</div>
        <div className="text-sm text-muted-foreground truncate">
          {ticket.id}
        </div>
      </div>

      {ticket.is_used !== undefined && (
        <>
          <Separator />
          <div className="grid grid-cols-2 gap-2">
            <div className="text-sm font-medium">Status:</div>
            <div
              className={`text-sm font-medium ${
                ticket.is_used ? "text-red-500" : "text-green-500"
              }`}
            >
              {ticket.is_used ? "Already Used" : "Valid"}
            </div>
          </div>
        </>
      )}
    </div>
  );
};

export default TicketDetails;
