PGDMP                          u            Shareff    9.6.1    9.6.1 C    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false            �           1262    16393    Shareff    DATABASE     �   CREATE DATABASE "Shareff" WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'English_Canada.1252' LC_CTYPE = 'English_Canada.1252';
    DROP DATABASE "Shareff";
             postgres    false            �           1262    16393    Shareff    COMMENT     =   COMMENT ON DATABASE "Shareff" IS 'Capstone design database';
                  postgres    false    2238                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
             postgres    false            �           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                  postgres    false    4                        3079    12387    plpgsql 	   EXTENSION     ?   CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;
    DROP EXTENSION plpgsql;
                  false            �           0    0    EXTENSION plpgsql    COMMENT     @   COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';
                       false    1                        3079    16595 	   uuid-ossp 	   EXTENSION     ?   CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;
    DROP EXTENSION "uuid-ossp";
                  false    4            �           0    0    EXTENSION "uuid-ossp"    COMMENT     W   COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';
                       false    2            �            1255    18444 `   createAddress(text, text, text, bigint, text, text, boolean, double precision, double precision)    FUNCTION     �  CREATE FUNCTION "createAddress"(city text, province text, "postalCode" text, "userId" bigint, line1 text, line2 text DEFAULT NULL::text, "isPrimary" boolean DEFAULT true, longitude double precision DEFAULT 0.0, latitude double precision DEFAULT 0.0) RETURNS uuid
    LANGUAGE plpgsql
    AS $$

DECLARE
	"addressId" uuid;
BEGIN
	"addressId" := uuid_generate_v4();
 	INSERT INTO "address" ("addressId", "line1", "line2", "city", "province", "postalCode", "userId", "isPrimary", "longitude", "latitude")
    VALUES ("addressId", "line1", "line2", "city", "province", "postalCode", "userId", "isPrimary", "longitude", "latitude");
    
    RETURN "addressId";
END;

$$;
 �   DROP FUNCTION public."createAddress"(city text, province text, "postalCode" text, "userId" bigint, line1 text, line2 text, "isPrimary" boolean, longitude double precision, latitude double precision);
       public       postgres    false    1    4            �            1255    18439 W   createBooking(bigint, uuid, bigint, timestamp with time zone, timestamp with time zone)    FUNCTION     �  CREATE FUNCTION "createBooking"("itemId" bigint, "rentRequestId" uuid, "userId" bigint, "startDate" timestamp with time zone, "endDate" timestamp with time zone) RETURNS uuid
    LANGUAGE plpgsql
    AS $$

DECLARE
	"bookingId" uuid;
BEGIN
	"bookingId" := uuid_generate_v4();
 	INSERT INTO "booking" ("bookingId", "itemId", "rentRequestId", "userId", "startDate", "endDate")
    VALUES ("bookingId", "itemId", "rentRequestId", "userId", "startDate", "endDate");
    
    RETURN "bookingId";
END;

$$;
 �   DROP FUNCTION public."createBooking"("itemId" bigint, "rentRequestId" uuid, "userId" bigint, "startDate" timestamp with time zone, "endDate" timestamp with time zone);
       public       postgres    false    1    4            �            1255    18440 (   createConversation(uuid, bigint, bigint)    FUNCTION     �  CREATE FUNCTION "createConversation"("rentRequestId" uuid, "renterId" bigint, "ownerId" bigint) RETURNS uuid
    LANGUAGE plpgsql
    AS $$

DECLARE
	"id" uuid;
    "startDate" timestamp with time zone;
BEGIN
	"id" := uuid_generate_v4();
    "startDate" := now;
 	INSERT INTO "conversation" ("id", "rentRequestId", "renterId", "ownerId", "startDate")
    VALUES ("id", "rentRequestId", "renterId", "ownerId", "startDate");
    
    RETURN "id";
END;

$$;
 f   DROP FUNCTION public."createConversation"("rentRequestId" uuid, "renterId" bigint, "ownerId" bigint);
       public       postgres    false    4    1            �            1255    18441 !   createMessage(bigint, text, uuid)    FUNCTION     �  CREATE FUNCTION "createMessage"("senderId" bigint, content text, "conversationId" uuid) RETURNS uuid
    LANGUAGE plpgsql
    AS $$

DECLARE
	"messageId" uuid;
    "timeSent" timestamp with time zone;
BEGIN
	"messageId" := uuid_generate_v4();
    "timeSent" := now;
 	INSERT INTO "message" ("messageId", "senderId", "timeSent", "content", "conversationId")
    VALUES ("messageId", "senderId", "timeSent", "content", "conversationId");
    
    RETURN "messageId";
END;

$$;
 ^   DROP FUNCTION public."createMessage"("senderId" bigint, content text, "conversationId" uuid);
       public       postgres    false    4    1            �            1255    18442 g   createRentRequest(bigint, bigint, timestamp with time zone, timestamp with time zone, text, text, text)    FUNCTION     v  CREATE FUNCTION "createRentRequest"("renterId" bigint, "itemId" bigint, "startDate" timestamp with time zone, "endDate" timestamp with time zone, status text DEFAULT NULL::text, comments text DEFAULT NULL::text, questions text DEFAULT NULL::text) RETURNS uuid
    LANGUAGE plpgsql
    AS $$

DECLARE
	"requestId" uuid;
BEGIN
	"requestId" := uuid_generate_v4();
 	INSERT INTO "rentRequest" ("requestId", "renterId", "itemId", "startDate", "endDate", "status", "comments", "questions")
    VALUES ("requestId", "renterId", "itemId", "startDate", "endDate", "status", "comments", "questions");
    
    RETURN "requestId";
END;

$$;
 �   DROP FUNCTION public."createRentRequest"("renterId" bigint, "itemId" bigint, "startDate" timestamp with time zone, "endDate" timestamp with time zone, status text, comments text, questions text);
       public       postgres    false    4    1            �            1255    18446 R   createRentalItem(text, text, double precision, uuid, bigint, text, text[], text[])    FUNCTION     ^  CREATE FUNCTION "createRentalItem"(title text, description text, price double precision, "addressId" uuid, "ownerId" bigint, "termsOfUse" text DEFAULT NULL::text, category text[] DEFAULT NULL::text[], photo text[] DEFAULT NULL::text[]) RETURNS uuid
    LANGUAGE plpgsql
    AS $$

DECLARE
	"itemId" bigint;
BEGIN
 	INSERT INTO "rentalItem" ("title", "description", "price", "addressId", "termsOfUse", "ownerId", "category", "photo")
    VALUES ("title", "description", "price", "addressId", "termsOfUse", "ownerId", "category", "photo")
    RETURNING "itemId" INTO "itemId";
    RETURN "itemId";
END;

$$;
 �   DROP FUNCTION public."createRentalItem"(title text, description text, price double precision, "addressId" uuid, "ownerId" bigint, "termsOfUse" text, category text[], photo text[]);
       public       postgres    false    4    1            �            1255    17835 .   createUser(text, text, text, text, text, text)    FUNCTION     D  CREATE FUNCTION "createUser"("firstName" text, "lastName" text, email text, password text, "photoUrl" text DEFAULT NULL::text, description text DEFAULT NULL::text) RETURNS uuid
    LANGUAGE plpgsql
    AS $$

DECLARE
	"userId" bigint;
    "avgRating" double precision;
BEGIN
    "avgRating" := NULL;
 	INSERT INTO "userTable" ("firstName", "lastName", "email", "password", "photoUrl", "description", "avgRating")
    VALUES ("firstName", "lastName", "email", "password", "photoUrl", "description", "avgRating")
    RETURNING "userId" INTO "userId";
    RETURN "userId";
END;

$$;
 �   DROP FUNCTION public."createUser"("firstName" text, "lastName" text, email text, password text, "photoUrl" text, description text);
       public       postgres    false    1    4            �            1255    18447 5   createUserReview(text, bigint, bigint, integer, text)    FUNCTION     :  CREATE FUNCTION "createUserReview"(title text, "userIdFor" bigint, "userIdFrom" bigint, rating integer, comment text DEFAULT NULL::text) RETURNS uuid
    LANGUAGE plpgsql
    AS $$

DECLARE
	"reviewId" uuid;
    "creationTime" timestamp with time zone;
BEGIN
	"reviewId" := uuid_generate_v4();
    "creationTime" := now;
 	INSERT INTO "userReview" ("reviewId", "title", "comment", "userIdFor", "userIdFrom", "rating", "creationTime")
    VALUES ("reviewId", "title", "comment", "userIdFor", "userIdFrom", "rating", "creationTime");
    
    RETURN "reviewId";
END;

$$;
 |   DROP FUNCTION public."createUserReview"(title text, "userIdFor" bigint, "userIdFrom" bigint, rating integer, comment text);
       public       postgres    false    1    4            �            1259    18314    address    TABLE     �  CREATE TABLE address (
    "addressId" uuid DEFAULT uuid_generate_v4() NOT NULL,
    line1 text NOT NULL,
    line2 text,
    city text NOT NULL,
    province text NOT NULL,
    "postalCode" text NOT NULL,
    "userId" bigint DEFAULT '-1'::integer NOT NULL,
    "isPrimary" boolean DEFAULT true NOT NULL,
    longitude double precision NOT NULL,
    latitude double precision NOT NULL
);
    DROP TABLE public.address;
       public         postgres    false    2    4    4            �           0    0    TABLE address    COMMENT     \   COMMENT ON TABLE address IS 'Stores address information for either an rental item or user';
            public       postgres    false    189            �            1259    18416    booking    TABLE     #  CREATE TABLE booking (
    "bookingId" uuid DEFAULT uuid_generate_v4() NOT NULL,
    "itemId" bigint DEFAULT '-1'::integer NOT NULL,
    "rentRequestId" uuid NOT NULL,
    "userId" bigint,
    "startDate" timestamp with time zone NOT NULL,
    "endDate" timestamp with time zone NOT NULL
);
    DROP TABLE public.booking;
       public         postgres    false    2    4    4            �            1259    18373    conversation    TABLE       CREATE TABLE conversation (
    id uuid DEFAULT uuid_generate_v4() NOT NULL,
    "rentRequestId" uuid NOT NULL,
    "renterId" bigint DEFAULT '-1'::integer NOT NULL,
    "ownerId" bigint DEFAULT '-1'::integer NOT NULL,
    "startDate" timestamp without time zone NOT NULL
);
     DROP TABLE public.conversation;
       public         postgres    false    2    4    4            �            1259    18396    message    TABLE     �   CREATE TABLE message (
    "messageId" uuid DEFAULT uuid_generate_v4() NOT NULL,
    "senderId" bigint DEFAULT '-1'::integer NOT NULL,
    "timeSent" timestamp with time zone NOT NULL,
    content text NOT NULL,
    "conversationId" uuid NOT NULL
);
    DROP TABLE public.message;
       public         postgres    false    2    4    4            �            1259    18352    rentRequest    TABLE     h  CREATE TABLE "rentRequest" (
    "requestId" uuid DEFAULT uuid_generate_v4() NOT NULL,
    "renterId" bigint DEFAULT '-1'::integer NOT NULL,
    "itemId" bigint DEFAULT '-1'::integer NOT NULL,
    "startDate" timestamp with time zone NOT NULL,
    "endDate" timestamp with time zone NOT NULL,
    status text NOT NULL,
    comments text,
    questions text
);
 !   DROP TABLE public."rentRequest";
       public         postgres    false    2    4    4            �            1259    18332 
   rentalItem    TABLE     K  CREATE TABLE "rentalItem" (
    "itemId" bigint NOT NULL,
    title text NOT NULL,
    description text NOT NULL,
    price double precision NOT NULL,
    "costPeriod" text NOT NULL,
    "addressId" uuid NOT NULL,
    "termsOfUse" text,
    "ownerId" bigint DEFAULT '-1'::integer NOT NULL,
    category text[],
    photo text[]
);
     DROP TABLE public."rentalItem";
       public         postgres    false    4            �            1259    18330    rentalItem_itemId_seq    SEQUENCE     y   CREATE SEQUENCE "rentalItem_itemId_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public."rentalItem_itemId_seq";
       public       postgres    false    4    191            �           0    0    rentalItem_itemId_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE "rentalItem_itemId_seq" OWNED BY "rentalItem"."itemId";
            public       postgres    false    190            �            1259    18293 
   userReview    TABLE     ;  CREATE TABLE "userReview" (
    "reviewId" uuid DEFAULT uuid_generate_v4() NOT NULL,
    title text,
    comment text,
    "userIdFor" bigint DEFAULT '-1'::integer NOT NULL,
    "userIdFrom" bigint DEFAULT '-1'::integer NOT NULL,
    rating integer NOT NULL,
    "creationTime" timestamp with time zone NOT NULL
);
     DROP TABLE public."userReview";
       public         postgres    false    2    4    4            �            1259    18283 	   userTable    TABLE     "  CREATE TABLE "userTable" (
    "userId" bigint NOT NULL,
    "firstName" text NOT NULL,
    "lastName" text NOT NULL,
    email text NOT NULL,
    password text NOT NULL,
    "photoUrl" text DEFAULT '/photos/white-image.png'::text,
    description text,
    "avgRating" double precision
);
    DROP TABLE public."userTable";
       public         postgres    false    4            �           0    0    TABLE "userTable"    COMMENT     f   COMMENT ON TABLE "userTable" IS 'Stores all information about registerd users of the Shareff System';
            public       postgres    false    187            �            1259    18281    userTable_userId_seq    SEQUENCE     x   CREATE SEQUENCE "userTable_userId_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public."userTable_userId_seq";
       public       postgres    false    4    187            �           0    0    userTable_userId_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE "userTable_userId_seq" OWNED BY "userTable"."userId";
            public       postgres    false    186                       2604    18335    rentalItem itemId    DEFAULT     n   ALTER TABLE ONLY "rentalItem" ALTER COLUMN "itemId" SET DEFAULT nextval('"rentalItem_itemId_seq"'::regclass);
 D   ALTER TABLE public."rentalItem" ALTER COLUMN "itemId" DROP DEFAULT;
       public       postgres    false    191    190    191                       2604    18286    userTable userId    DEFAULT     l   ALTER TABLE ONLY "userTable" ALTER COLUMN "userId" SET DEFAULT nextval('"userTable_userId_seq"'::regclass);
 C   ALTER TABLE public."userTable" ALTER COLUMN "userId" DROP DEFAULT;
       public       postgres    false    186    187    187            �          0    18314    address 
   TABLE DATA                  COPY address ("addressId", line1, line2, city, province, "postalCode", "userId", "isPrimary", longitude, latitude) FROM stdin;
    public       postgres    false    189   �d       �          0    18416    booking 
   TABLE DATA               d   COPY booking ("bookingId", "itemId", "rentRequestId", "userId", "startDate", "endDate") FROM stdin;
    public       postgres    false    195   e       �          0    18373    conversation 
   TABLE DATA               X   COPY conversation (id, "rentRequestId", "renterId", "ownerId", "startDate") FROM stdin;
    public       postgres    false    193   )e       �          0    18396    message 
   TABLE DATA               Z   COPY message ("messageId", "senderId", "timeSent", content, "conversationId") FROM stdin;
    public       postgres    false    194   Fe       �          0    18352    rentRequest 
   TABLE DATA               x   COPY "rentRequest" ("requestId", "renterId", "itemId", "startDate", "endDate", status, comments, questions) FROM stdin;
    public       postgres    false    192   ce       �          0    18332 
   rentalItem 
   TABLE DATA               �   COPY "rentalItem" ("itemId", title, description, price, "costPeriod", "addressId", "termsOfUse", "ownerId", category, photo) FROM stdin;
    public       postgres    false    191   �e       �           0    0    rentalItem_itemId_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('"rentalItem_itemId_seq"', 1, false);
            public       postgres    false    190            �          0    18293 
   userReview 
   TABLE DATA               n   COPY "userReview" ("reviewId", title, comment, "userIdFor", "userIdFrom", rating, "creationTime") FROM stdin;
    public       postgres    false    188   �e       �          0    18283 	   userTable 
   TABLE DATA               x   COPY "userTable" ("userId", "firstName", "lastName", email, password, "photoUrl", description, "avgRating") FROM stdin;
    public       postgres    false    187   �e       �           0    0    userTable_userId_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('"userTable_userId_seq"', 2, true);
            public       postgres    false    186            !           2606    18324    address addressId 
   CONSTRAINT     S   ALTER TABLE ONLY address
    ADD CONSTRAINT "addressId" PRIMARY KEY ("addressId");
 =   ALTER TABLE ONLY public.address DROP CONSTRAINT "addressId";
       public         postgres    false    189    189            +           2606    18422    booking bookingId 
   CONSTRAINT     S   ALTER TABLE ONLY booking
    ADD CONSTRAINT "bookingId" PRIMARY KEY ("bookingId");
 =   ALTER TABLE ONLY public.booking DROP CONSTRAINT "bookingId";
       public         postgres    false    195    195            '           2606    18380    conversation conversation_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY conversation
    ADD CONSTRAINT conversation_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.conversation DROP CONSTRAINT conversation_pkey;
       public         postgres    false    193    193            #           2606    18341    rentalItem itemId 
   CONSTRAINT     R   ALTER TABLE ONLY "rentalItem"
    ADD CONSTRAINT "itemId" PRIMARY KEY ("itemId");
 ?   ALTER TABLE ONLY public."rentalItem" DROP CONSTRAINT "itemId";
       public         postgres    false    191    191            )           2606    18405    message messageId 
   CONSTRAINT     S   ALTER TABLE ONLY message
    ADD CONSTRAINT "messageId" PRIMARY KEY ("messageId");
 =   ALTER TABLE ONLY public.message DROP CONSTRAINT "messageId";
       public         postgres    false    194    194            %           2606    18362    rentRequest requestId 
   CONSTRAINT     Y   ALTER TABLE ONLY "rentRequest"
    ADD CONSTRAINT "requestId" PRIMARY KEY ("requestId");
 C   ALTER TABLE ONLY public."rentRequest" DROP CONSTRAINT "requestId";
       public         postgres    false    192    192                       2606    18303    userReview reviewId 
   CONSTRAINT     V   ALTER TABLE ONLY "userReview"
    ADD CONSTRAINT "reviewId" PRIMARY KEY ("reviewId");
 A   ALTER TABLE ONLY public."userReview" DROP CONSTRAINT "reviewId";
       public         postgres    false    188    188                       2606    18292    userTable userId 
   CONSTRAINT     Q   ALTER TABLE ONLY "userTable"
    ADD CONSTRAINT "userId" PRIMARY KEY ("userId");
 >   ALTER TABLE ONLY public."userTable" DROP CONSTRAINT "userId";
       public         postgres    false    187    187            /           2606    18342    rentalItem addressId    FK CONSTRAINT     �   ALTER TABLE ONLY "rentalItem"
    ADD CONSTRAINT "addressId" FOREIGN KEY ("addressId") REFERENCES address("addressId") ON UPDATE CASCADE ON DELETE SET NULL;
 B   ALTER TABLE ONLY public."rentalItem" DROP CONSTRAINT "addressId";
       public       postgres    false    2081    191    189            6           2606    18406    message conversationId    FK CONSTRAINT     �   ALTER TABLE ONLY message
    ADD CONSTRAINT "conversationId" FOREIGN KEY ("conversationId") REFERENCES conversation(id) ON DELETE CASCADE;
 B   ALTER TABLE ONLY public.message DROP CONSTRAINT "conversationId";
       public       postgres    false    193    194    2087            1           2606    18363    rentRequest itemId    FK CONSTRAINT     �   ALTER TABLE ONLY "rentRequest"
    ADD CONSTRAINT "itemId" FOREIGN KEY ("itemId") REFERENCES "rentalItem"("itemId") ON UPDATE CASCADE ON DELETE CASCADE;
 @   ALTER TABLE ONLY public."rentRequest" DROP CONSTRAINT "itemId";
       public       postgres    false    192    191    2083            8           2606    18423    booking itemId    FK CONSTRAINT     �   ALTER TABLE ONLY booking
    ADD CONSTRAINT "itemId" FOREIGN KEY ("itemId") REFERENCES "rentalItem"("itemId") ON UPDATE CASCADE ON DELETE CASCADE;
 :   ALTER TABLE ONLY public.booking DROP CONSTRAINT "itemId";
       public       postgres    false    2083    195    191            0           2606    18347    rentalItem ownerId    FK CONSTRAINT     �   ALTER TABLE ONLY "rentalItem"
    ADD CONSTRAINT "ownerId" FOREIGN KEY ("ownerId") REFERENCES "userTable"("userId") ON UPDATE CASCADE ON DELETE CASCADE;
 @   ALTER TABLE ONLY public."rentalItem" DROP CONSTRAINT "ownerId";
       public       postgres    false    191    187    2077            3           2606    18381    conversation ownerId    FK CONSTRAINT     �   ALTER TABLE ONLY conversation
    ADD CONSTRAINT "ownerId" FOREIGN KEY ("ownerId") REFERENCES "userTable"("userId") ON DELETE CASCADE;
 @   ALTER TABLE ONLY public.conversation DROP CONSTRAINT "ownerId";
       public       postgres    false    187    193    2077            4           2606    18386    conversation rentRequestId    FK CONSTRAINT     �   ALTER TABLE ONLY conversation
    ADD CONSTRAINT "rentRequestId" FOREIGN KEY ("rentRequestId") REFERENCES "rentRequest"("requestId");
 F   ALTER TABLE ONLY public.conversation DROP CONSTRAINT "rentRequestId";
       public       postgres    false    193    2085    192            9           2606    18428    booking rentRequestId    FK CONSTRAINT     �   ALTER TABLE ONLY booking
    ADD CONSTRAINT "rentRequestId" FOREIGN KEY ("rentRequestId") REFERENCES "rentRequest"("requestId");
 A   ALTER TABLE ONLY public.booking DROP CONSTRAINT "rentRequestId";
       public       postgres    false    195    2085    192            2           2606    18368    rentRequest renterId    FK CONSTRAINT     �   ALTER TABLE ONLY "rentRequest"
    ADD CONSTRAINT "renterId" FOREIGN KEY ("renterId") REFERENCES "userTable"("userId") ON UPDATE CASCADE ON DELETE CASCADE;
 B   ALTER TABLE ONLY public."rentRequest" DROP CONSTRAINT "renterId";
       public       postgres    false    187    2077    192            5           2606    18391    conversation renterId    FK CONSTRAINT     �   ALTER TABLE ONLY conversation
    ADD CONSTRAINT "renterId" FOREIGN KEY ("renterId") REFERENCES "userTable"("userId") ON UPDATE CASCADE ON DELETE CASCADE;
 A   ALTER TABLE ONLY public.conversation DROP CONSTRAINT "renterId";
       public       postgres    false    187    2077    193            7           2606    18411    message senderId    FK CONSTRAINT     r   ALTER TABLE ONLY message
    ADD CONSTRAINT "senderId" FOREIGN KEY ("senderId") REFERENCES "userTable"("userId");
 <   ALTER TABLE ONLY public.message DROP CONSTRAINT "senderId";
       public       postgres    false    187    194    2077            .           2606    18325    address userId    FK CONSTRAINT     �   ALTER TABLE ONLY address
    ADD CONSTRAINT "userId" FOREIGN KEY ("userId") REFERENCES "userTable"("userId") ON UPDATE CASCADE ON DELETE CASCADE;
 :   ALTER TABLE ONLY public.address DROP CONSTRAINT "userId";
       public       postgres    false    187    189    2077            :           2606    18433    booking userId    FK CONSTRAINT     n   ALTER TABLE ONLY booking
    ADD CONSTRAINT "userId" FOREIGN KEY ("userId") REFERENCES "userTable"("userId");
 :   ALTER TABLE ONLY public.booking DROP CONSTRAINT "userId";
       public       postgres    false    2077    195    187            ,           2606    18304    userReview userIdFor    FK CONSTRAINT     �   ALTER TABLE ONLY "userReview"
    ADD CONSTRAINT "userIdFor" FOREIGN KEY ("userIdFor") REFERENCES "userTable"("userId") ON UPDATE CASCADE ON DELETE CASCADE;
 B   ALTER TABLE ONLY public."userReview" DROP CONSTRAINT "userIdFor";
       public       postgres    false    2077    187    188            -           2606    18309    userReview userIdFrom    FK CONSTRAINT     �   ALTER TABLE ONLY "userReview"
    ADD CONSTRAINT "userIdFrom" FOREIGN KEY ("userIdFrom") REFERENCES "userTable"("userId") ON UPDATE CASCADE ON DELETE CASCADE;
 C   ALTER TABLE ONLY public."userReview" DROP CONSTRAINT "userIdFrom";
       public       postgres    false    2077    188    187            �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �   U   x�3�t��̩�t/M��L����L)MI-)12q�-��K���,H,..�/J��/��/�/�/��,I���MLO�+�K��"�=... L�4     