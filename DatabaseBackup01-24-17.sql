PGDMP     5    9                 u            Shareff    9.6.1    9.6.1 7    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false            �           1262    16393    Shareff    DATABASE     �   CREATE DATABASE "Shareff" WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'English_Canada.1252' LC_CTYPE = 'English_Canada.1252';
    DROP DATABASE "Shareff";
             postgres    false            �           1262    16393    Shareff    COMMENT     =   COMMENT ON DATABASE "Shareff" IS 'Capstone design database';
                  postgres    false    2222                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
             postgres    false            �           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                  postgres    false    4                        3079    12387    plpgsql 	   EXTENSION     ?   CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;
    DROP EXTENSION plpgsql;
                  false            �           0    0    EXTENSION plpgsql    COMMENT     @   COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';
                       false    1                        3079    16595 	   uuid-ossp 	   EXTENSION     ?   CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;
    DROP EXTENSION "uuid-ossp";
                  false    4            �           0    0    EXTENSION "uuid-ossp"    COMMENT     W   COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';
                       false    2            �            1259    17447    address    TABLE       CREATE TABLE address (
    "addressId" uuid DEFAULT uuid_generate_v4() NOT NULL,
    line1 text NOT NULL,
    line2 text,
    city text NOT NULL,
    province text NOT NULL,
    "postalCode" text NOT NULL,
    "userId" uuid NOT NULL,
    "isPrimary" boolean DEFAULT true NOT NULL
);
    DROP TABLE public.address;
       public         postgres    false    2    4    4            �           0    0    TABLE address    COMMENT     \   COMMENT ON TABLE address IS 'Stores address information for either an rental item or user';
            public       postgres    false    187            �            1259    17531    booking    TABLE     �   CREATE TABLE booking (
    "bookingId" uuid DEFAULT uuid_generate_v4() NOT NULL,
    "itemId" uuid NOT NULL,
    "rentRequestId" uuid NOT NULL,
    "userId" uuid,
    "startDate" date NOT NULL,
    "endDate" date NOT NULL
);
    DROP TABLE public.booking;
       public         postgres    false    2    4    4            �            1259    17552    conversation    TABLE     �   CREATE TABLE conversation (
    id uuid DEFAULT uuid_generate_v4() NOT NULL,
    "rentRequestId" uuid NOT NULL,
    "renterId" uuid NOT NULL,
    "ownerId" uuid NOT NULL,
    "startDate" timestamp without time zone NOT NULL
);
     DROP TABLE public.conversation;
       public         postgres    false    2    4    4            �            1259    17573    message    TABLE     �   CREATE TABLE message (
    "messageId" uuid DEFAULT uuid_generate_v4() NOT NULL,
    "senderId" uuid NOT NULL,
    "timeSent" timestamp with time zone NOT NULL,
    content text NOT NULL,
    "conversationId" uuid NOT NULL
);
    DROP TABLE public.message;
       public         postgres    false    2    4    4            �            1259    17512    rentRequest    TABLE       CREATE TABLE "rentRequest" (
    "requestId" uuid DEFAULT uuid_generate_v4() NOT NULL,
    "renterId" uuid NOT NULL,
    "itemId" uuid NOT NULL,
    "startDate" date NOT NULL,
    "endDate" date NOT NULL,
    status text NOT NULL,
    comments text,
    questions text
);
 !   DROP TABLE public."rentRequest";
       public         postgres    false    2    4    4            �            1259    17480 
   rentalItem    TABLE       CREATE TABLE "rentalItem" (
    "itemId" uuid DEFAULT uuid_generate_v4() NOT NULL,
    title text NOT NULL,
    category json[],
    description text NOT NULL,
    price double precision NOT NULL,
    "addressId" uuid,
    "termsOfUse" text,
    "ownerId" uuid NOT NULL
);
     DROP TABLE public."rentalItem";
       public         postgres    false    2    4    4            �            1259    17499    rentalItemPhoto    TABLE     ]   CREATE TABLE "rentalItemPhoto" (
    "itemId" uuid NOT NULL,
    "photoUrl" text NOT NULL
);
 %   DROP TABLE public."rentalItemPhoto";
       public         postgres    false    4            �            1259    17461 
   userReview    TABLE       CREATE TABLE "userReview" (
    "reviewId" uuid DEFAULT uuid_generate_v4() NOT NULL,
    title text,
    comment text,
    "userIdFor" uuid NOT NULL,
    "userIdFrom" uuid NOT NULL,
    rating integer NOT NULL,
    "creationTime" timestamp with time zone NOT NULL
);
     DROP TABLE public."userReview";
       public         postgres    false    2    4    4            �            1259    17438 	   userTable    TABLE       CREATE TABLE "userTable" (
    "userId" uuid DEFAULT uuid_generate_v4() NOT NULL,
    "firstName" text NOT NULL,
    "lastName" text NOT NULL,
    email text NOT NULL,
    password text NOT NULL,
    "photoUrl" text,
    description text,
    "avgRating" double precision
);
    DROP TABLE public."userTable";
       public         postgres    false    2    4    4            �           0    0    TABLE "userTable"    COMMENT     f   COMMENT ON TABLE "userTable" IS 'Stores all information about registerd users of the Shareff System';
            public       postgres    false    186            �          0    17447    address 
   TABLE DATA               j   COPY address ("addressId", line1, line2, city, province, "postalCode", "userId", "isPrimary") FROM stdin;
    public       postgres    false    187   C       �          0    17531    booking 
   TABLE DATA               d   COPY booking ("bookingId", "itemId", "rentRequestId", "userId", "startDate", "endDate") FROM stdin;
    public       postgres    false    192   *C       �          0    17552    conversation 
   TABLE DATA               X   COPY conversation (id, "rentRequestId", "renterId", "ownerId", "startDate") FROM stdin;
    public       postgres    false    193   GC       �          0    17573    message 
   TABLE DATA               Z   COPY message ("messageId", "senderId", "timeSent", content, "conversationId") FROM stdin;
    public       postgres    false    194   dC       �          0    17512    rentRequest 
   TABLE DATA               x   COPY "rentRequest" ("requestId", "renterId", "itemId", "startDate", "endDate", status, comments, questions) FROM stdin;
    public       postgres    false    191   �C       �          0    17480 
   rentalItem 
   TABLE DATA               t   COPY "rentalItem" ("itemId", title, category, description, price, "addressId", "termsOfUse", "ownerId") FROM stdin;
    public       postgres    false    189   �C       �          0    17499    rentalItemPhoto 
   TABLE DATA               :   COPY "rentalItemPhoto" ("itemId", "photoUrl") FROM stdin;
    public       postgres    false    190   �C       �          0    17461 
   userReview 
   TABLE DATA               n   COPY "userReview" ("reviewId", title, comment, "userIdFor", "userIdFrom", rating, "creationTime") FROM stdin;
    public       postgres    false    188   �C       �          0    17438 	   userTable 
   TABLE DATA               x   COPY "userTable" ("userId", "firstName", "lastName", email, password, "photoUrl", description, "avgRating") FROM stdin;
    public       postgres    false    186   �C                  2606    17455    address addressId 
   CONSTRAINT     S   ALTER TABLE ONLY address
    ADD CONSTRAINT "addressId" PRIMARY KEY ("addressId");
 =   ALTER TABLE ONLY public.address DROP CONSTRAINT "addressId";
       public         postgres    false    187    187                       2606    17536    booking bookingId 
   CONSTRAINT     S   ALTER TABLE ONLY booking
    ADD CONSTRAINT "bookingId" PRIMARY KEY ("bookingId");
 =   ALTER TABLE ONLY public.booking DROP CONSTRAINT "bookingId";
       public         postgres    false    192    192                       2606    17557    conversation conversation_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY conversation
    ADD CONSTRAINT conversation_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.conversation DROP CONSTRAINT conversation_pkey;
       public         postgres    false    193    193                       2606    17488    rentalItem itemId 
   CONSTRAINT     R   ALTER TABLE ONLY "rentalItem"
    ADD CONSTRAINT "itemId" PRIMARY KEY ("itemId");
 ?   ALTER TABLE ONLY public."rentalItem" DROP CONSTRAINT "itemId";
       public         postgres    false    189    189                       2606    17581    message messageId 
   CONSTRAINT     S   ALTER TABLE ONLY message
    ADD CONSTRAINT "messageId" PRIMARY KEY ("messageId");
 =   ALTER TABLE ONLY public.message DROP CONSTRAINT "messageId";
       public         postgres    false    194    194                       2606    17506 $   rentalItemPhoto rentalItemPhoto_pkey 
   CONSTRAINT     q   ALTER TABLE ONLY "rentalItemPhoto"
    ADD CONSTRAINT "rentalItemPhoto_pkey" PRIMARY KEY ("itemId", "photoUrl");
 R   ALTER TABLE ONLY public."rentalItemPhoto" DROP CONSTRAINT "rentalItemPhoto_pkey";
       public         postgres    false    190    190    190                       2606    17520    rentRequest requestId 
   CONSTRAINT     Y   ALTER TABLE ONLY "rentRequest"
    ADD CONSTRAINT "requestId" PRIMARY KEY ("requestId");
 C   ALTER TABLE ONLY public."rentRequest" DROP CONSTRAINT "requestId";
       public         postgres    false    191    191                       2606    17469    userReview reviewId 
   CONSTRAINT     V   ALTER TABLE ONLY "userReview"
    ADD CONSTRAINT "reviewId" PRIMARY KEY ("reviewId");
 A   ALTER TABLE ONLY public."userReview" DROP CONSTRAINT "reviewId";
       public         postgres    false    188    188                       2606    17446    userTable userId 
   CONSTRAINT     Q   ALTER TABLE ONLY "userTable"
    ADD CONSTRAINT "userId" PRIMARY KEY ("userId");
 >   ALTER TABLE ONLY public."userTable" DROP CONSTRAINT "userId";
       public         postgres    false    186    186                       2606    17489    rentalItem addressId    FK CONSTRAINT     �   ALTER TABLE ONLY "rentalItem"
    ADD CONSTRAINT "addressId" FOREIGN KEY ("addressId") REFERENCES address("addressId") ON UPDATE CASCADE ON DELETE SET NULL;
 B   ALTER TABLE ONLY public."rentalItem" DROP CONSTRAINT "addressId";
       public       postgres    false    187    2061    189            *           2606    17582    message conversationId    FK CONSTRAINT     �   ALTER TABLE ONLY message
    ADD CONSTRAINT "conversationId" FOREIGN KEY ("conversationId") REFERENCES conversation(id) ON DELETE CASCADE;
 B   ALTER TABLE ONLY public.message DROP CONSTRAINT "conversationId";
       public       postgres    false    194    2073    193            !           2606    17507    rentalItemPhoto itemId    FK CONSTRAINT     �   ALTER TABLE ONLY "rentalItemPhoto"
    ADD CONSTRAINT "itemId" FOREIGN KEY ("itemId") REFERENCES "rentalItem"("itemId") ON UPDATE CASCADE ON DELETE CASCADE;
 D   ALTER TABLE ONLY public."rentalItemPhoto" DROP CONSTRAINT "itemId";
       public       postgres    false    190    2065    189            "           2606    17521    rentRequest itemId    FK CONSTRAINT     �   ALTER TABLE ONLY "rentRequest"
    ADD CONSTRAINT "itemId" FOREIGN KEY ("itemId") REFERENCES "rentalItem"("itemId") ON UPDATE CASCADE ON DELETE CASCADE;
 @   ALTER TABLE ONLY public."rentRequest" DROP CONSTRAINT "itemId";
       public       postgres    false    191    189    2065            $           2606    17537    booking itemId    FK CONSTRAINT     �   ALTER TABLE ONLY booking
    ADD CONSTRAINT "itemId" FOREIGN KEY ("itemId") REFERENCES "rentalItem"("itemId") ON UPDATE CASCADE ON DELETE CASCADE;
 :   ALTER TABLE ONLY public.booking DROP CONSTRAINT "itemId";
       public       postgres    false    189    2065    192                        2606    17494    rentalItem ownerId    FK CONSTRAINT     �   ALTER TABLE ONLY "rentalItem"
    ADD CONSTRAINT "ownerId" FOREIGN KEY ("ownerId") REFERENCES "userTable"("userId") ON UPDATE CASCADE ON DELETE CASCADE;
 @   ALTER TABLE ONLY public."rentalItem" DROP CONSTRAINT "ownerId";
       public       postgres    false    2059    189    186            '           2606    17558    conversation ownerId    FK CONSTRAINT     �   ALTER TABLE ONLY conversation
    ADD CONSTRAINT "ownerId" FOREIGN KEY ("ownerId") REFERENCES "userTable"("userId") ON DELETE CASCADE;
 @   ALTER TABLE ONLY public.conversation DROP CONSTRAINT "ownerId";
       public       postgres    false    186    2059    193            %           2606    17542    booking rentRequestId    FK CONSTRAINT     �   ALTER TABLE ONLY booking
    ADD CONSTRAINT "rentRequestId" FOREIGN KEY ("rentRequestId") REFERENCES "rentRequest"("requestId");
 A   ALTER TABLE ONLY public.booking DROP CONSTRAINT "rentRequestId";
       public       postgres    false    2069    192    191            )           2606    17568    conversation rentRequestId    FK CONSTRAINT     �   ALTER TABLE ONLY conversation
    ADD CONSTRAINT "rentRequestId" FOREIGN KEY ("rentRequestId") REFERENCES "rentRequest"("requestId");
 F   ALTER TABLE ONLY public.conversation DROP CONSTRAINT "rentRequestId";
       public       postgres    false    2069    191    193            #           2606    17526    rentRequest renterId    FK CONSTRAINT     �   ALTER TABLE ONLY "rentRequest"
    ADD CONSTRAINT "renterId" FOREIGN KEY ("renterId") REFERENCES "userTable"("userId") ON UPDATE CASCADE ON DELETE CASCADE;
 B   ALTER TABLE ONLY public."rentRequest" DROP CONSTRAINT "renterId";
       public       postgres    false    191    2059    186            (           2606    17563    conversation renterId    FK CONSTRAINT     �   ALTER TABLE ONLY conversation
    ADD CONSTRAINT "renterId" FOREIGN KEY ("renterId") REFERENCES "userTable"("userId") ON UPDATE CASCADE ON DELETE CASCADE;
 A   ALTER TABLE ONLY public.conversation DROP CONSTRAINT "renterId";
       public       postgres    false    193    186    2059            +           2606    17587    message senderId    FK CONSTRAINT     r   ALTER TABLE ONLY message
    ADD CONSTRAINT "senderId" FOREIGN KEY ("senderId") REFERENCES "userTable"("userId");
 <   ALTER TABLE ONLY public.message DROP CONSTRAINT "senderId";
       public       postgres    false    194    2059    186            &           2606    17547    booking userId    FK CONSTRAINT     n   ALTER TABLE ONLY booking
    ADD CONSTRAINT "userId" FOREIGN KEY ("userId") REFERENCES "userTable"("userId");
 :   ALTER TABLE ONLY public.booking DROP CONSTRAINT "userId";
       public       postgres    false    2059    192    186                       2606    17777    address userId    FK CONSTRAINT     �   ALTER TABLE ONLY address
    ADD CONSTRAINT "userId" FOREIGN KEY ("userId") REFERENCES "userTable"("userId") ON UPDATE CASCADE ON DELETE CASCADE;
 :   ALTER TABLE ONLY public.address DROP CONSTRAINT "userId";
       public       postgres    false    2059    186    187                       2606    17470    userReview userIdFor    FK CONSTRAINT     �   ALTER TABLE ONLY "userReview"
    ADD CONSTRAINT "userIdFor" FOREIGN KEY ("userIdFor") REFERENCES "userTable"("userId") ON UPDATE CASCADE ON DELETE CASCADE;
 B   ALTER TABLE ONLY public."userReview" DROP CONSTRAINT "userIdFor";
       public       postgres    false    188    2059    186                       2606    17475    userReview userIdFrom    FK CONSTRAINT     �   ALTER TABLE ONLY "userReview"
    ADD CONSTRAINT "userIdFrom" FOREIGN KEY ("userIdFrom") REFERENCES "userTable"("userId") ON UPDATE CASCADE ON DELETE CASCADE;
 C   ALTER TABLE ONLY public."userReview" DROP CONSTRAINT "userIdFrom";
       public       postgres    false    188    186    2059            �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �     